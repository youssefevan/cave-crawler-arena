extends CharacterBody2D
class_name Player

@onready var sprite : Sprite2D = $Sprite
@onready var attack_range : Area2D = $AttackRange
@onready var animator : AnimationPlayer = $Animator

@onready var state_manager : StateManager = $StateManager
@onready var idle : State = $StateManager/Idle
@onready var move : State = $StateManager/Move
@onready var die : State = $StateManager/Die

@export var bullet : PackedScene

var input := Vector2.ZERO
var attack_input := false

var speed := 30.0
var accel := 40.0
var decel := 20.0

var can_attack := true

func _ready():
	state_manager.init(self)
	
	regen()

func _physics_process(delta):
	state_manager.physics_update(delta)
	
	speed = Global.player_stats["speed"]
	#$AttackRange/Collider.shape.radius = Global.player_stats["atkrng"]
	$PickupRange/Collider.shape.radius = Global.player_stats["pickup_range"]
	
	move_and_slide()

func handle_input():
	input.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	input = input.normalized()

func handle_aim():
	var enemies_in_range = []
	var entities_in_range = attack_range.get_overlapping_bodies()
	for i in entities_in_range:
		if i is Enemy:
			enemies_in_range.append(i)
	
	$Weapon.look_at(get_global_mouse_position())
	attack()
	
	#if enemies_in_range.size() > 0:
		#var target_enemy = enemies_in_range.front()
		#$Weapon.look_at(target_enemy.global_position)
		#attack()

func attack():
	if can_attack:
		var attack = bullet.instantiate()
		attack.scale = Vector2(1, 1) * Global.player_stats["firerate"]
		attack.rotation = $Weapon.global_rotation
		attack.global_position = $Weapon/Muzzle.global_position
		get_parent().bullets.add_child(attack)
		can_attack = false
		await get_tree().create_timer(Global.player_stats["firerate"], true).timeout
		can_attack = true

func regen():
	await get_tree().create_timer(Global.player_stats["regen_rate"], false).timeout
	if state_manager.current_state != die:
		if Global.player_stats["health"] < Global.player_stats["maxhp"]:
			Global.player_stats["health"] += 1.0 * Global.player_stats["regen"]
			Global.player_stats["health"] = min(Global.player_stats["health"], Global.player_stats["maxhp"])
		regen()

func get_hit():
	Global.player_stats["health"] -= 10

func _on_pickup_range_area_entered(area):
	if area is Pickup:
		area.player = self

func _on_hurtbox_area_entered(area):
	if area.get_collision_layer_value(4) and area.is_in_group("Enemy"):
		get_hit()
