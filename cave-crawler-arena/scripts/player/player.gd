extends CharacterBody2D
class_name Player

signal dead

@onready var sprite : Sprite2D = $Sprite
@onready var attack_range : Area2D = $AttackRange
@onready var animator : AnimationPlayer = $Animator

@onready var state_manager : StateManager = $StateManager
@onready var idle : State = $StateManager/Idle
@onready var move : State = $StateManager/Move
@onready var die : State = $StateManager/Die

@export var bullet : PackedScene

@onready var shoot_sfx = preload("res://audio/player_shoot.ogg")
@onready var hurt_sfx = preload("res://audio/player_hurt.ogg")

@onready var bomb_scene = preload("res://scenes/hazards/bomb.tscn")

var camera : Camera2D
var shake_strength := 3.0
var shake_decay := 12.0
var current_shake := 0.0

var input := Vector2.ZERO
var attack_input := false

var speed := 38.0
var accel := 40.0
var decel := 20.0

var can_attack := true
var invulnerable := false

var can_spawn_bomb := true

var enemies_in_heal_aura := false

var heal_aura_color := Color.TRANSPARENT
var target_heal_aura_color := Color.TRANSPARENT

func _ready():
	
	for i in get_children():
		if i is Camera2D:
			camera = i
	
	Global.health = Global.get_stat("max_health")
	state_manager.init(self)
	regen()

func _process(delta: float) -> void:
	if current_shake > 0.0:
		current_shake = lerpf(current_shake, 0.0, shake_decay * delta)
		
		camera.offset = Vector2(
				randf_range(-current_shake, current_shake),
				randf_range(-current_shake, current_shake)
			)

func _physics_process(delta):
	state_manager.physics_update(delta)
	
	speed = Global.get_stat("speed")
	$PickupRange/Collider.shape.radius = Global.get_stat("pickup_range")
	
	var heal_aura = Global.get_item("heal_aura")
	if heal_aura > 0:
		$HealAura/Collider.shape.radius = heal_aura
		$HealAura/Collider.disabled = false
		enemies_in_heal_aura = $HealAura.has_overlapping_bodies()
	else:
		$HealAura/Collider.disabled = true
		enemies_in_heal_aura = false
	
	
	target_heal_aura_color = Color.from_hsv(0.11, 1.0, 1.0, float(enemies_in_heal_aura)/3.0)
	heal_aura_color = lerp(heal_aura_color, target_heal_aura_color, 5.0 * delta)
	
	
	if Global.get_item("bomb") > 0.0:
		spawn_bomb()
	
	queue_redraw()
	
	move_and_slide()

func _draw():
	draw_arc(Vector2.ZERO, Global.get_item("heal_aura"), 0, 360, 64, heal_aura_color, 1.0, false)

func handle_input():
	input.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	input = input.normalized()

func handle_aim():
	#var enemies_in_range = []
	#var entities_in_range = attack_range.get_overlapping_bodies()
	#for i in entities_in_range:
		#if i is Enemy:
			#enemies_in_range.append(i)
	
	$Weapon.look_at(get_global_mouse_position())
	
	$Weapon/Sprite.flip_v = (global_position.x - get_global_mouse_position().x >= 0.0)
	
	attack()

func attack():
	if can_attack:
		#AudioManager.play_sfx(shoot_sfx)
		
		var num_bullets = Global.get_item("splitshot") + 1
		var spread_angle_degrees = 45.0
		
		if num_bullets > 1:
			if num_bullets == 2:
				spread_angle_degrees = 20.0
			
			var start_angle = $Weapon.rotation_degrees - spread_angle_degrees / 2
			var angle_step = spread_angle_degrees / (num_bullets - 1)
			
			for i in num_bullets:
				var b = bullet.instantiate()
				b.rotation_degrees = start_angle + angle_step * i
				b.global_position = $Weapon/Muzzle.global_position
				get_parent().bullets.add_child(b)
		else:
			var b = bullet.instantiate()
			b.rotation = $Weapon.global_rotation
			b.global_position = $Weapon/Muzzle.global_position
			get_parent().bullets.add_child(b)
		
		$Weapon/Animator.stop()
		$Weapon/Animator.play("fire")
		can_attack = false
		await get_tree().create_timer(Global.get_stat("firerate"), false).timeout
		can_attack = true

func spawn_bomb():
	if can_spawn_bomb and Global.get_item("bomb") > 0:
		var b = bomb_scene.instantiate()
		b.global_position = global_position
		get_tree().get_root().call_deferred("add_child", b)
		
		can_spawn_bomb = false
		await get_tree().create_timer(Global.get_item("bomb"), false).timeout
		can_spawn_bomb = true

func regen():
	var regen_rate = Global.get_stat("regen_rate")
	if enemies_in_heal_aura:
		regen_rate /= 2.0
	#print(regen_rate, enemies_in_heal_aura)
	await get_tree().create_timer(regen_rate, false).timeout
	if state_manager.current_state != die:
		if Global.health < Global.get_stat("max_health"):
			Global.health += 1.0
			Global.health = clamp(Global.health, 0, Global.get_stat("max_health"))
		
		regen()

func get_hit():
	AudioManager.play_sfx(hurt_sfx)
	
	Engine.time_scale = 0.1
	await get_tree().create_timer(0.15, false, false, true).timeout
	Engine.time_scale = 1.0
	
	current_shake = shake_strength
	
	Global.health = max(0, Global.health - 10)
	
	if Global.health <= 0:
		dead.emit()
	
	invulnerable = true
	$Hurtbox/Collider.disabled = true
	hit_flash()
	await get_tree().create_timer(0.6, false).timeout
	$Hurtbox/Collider.disabled = false
	invulnerable = false

func hit_flash() -> void:
	while invulnerable:
		$Sprite.modulate = Color(1.0, 0.0, 0.0, 0.2)
		await get_tree().create_timer(0.1, false).timeout
		$Sprite.modulate = Color(1.0, 0.0, 0.0, 1.0)
		await get_tree().create_timer(0.11, false).timeout
	$Sprite.modulate = Color(1, 1, 1, 1)

func _on_pickup_range_area_entered(area):
	if area is Pickup:
		area.player = self

func _on_hurtbox_area_entered(area):
	if area.get_collision_layer_value(4) and area.is_in_group("Enemy"):
		if !invulnerable and Global.health > 0:
			get_hit()
