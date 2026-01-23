extends CharacterBody2D
class_name Enemy

signal died

@onready var coin : PackedScene = preload("res://scenes/pickups/coin.tscn")
#@onready var fire_partices = preload("res://scenes/effects/fire.tscn")

@onready var hurt_sfx = preload("res://audio/enemy_hit.ogg")

var world : Node2D
var player : Player

var accel := 5.0

@export var enemy_name : String

@export var speed := 30.0
@export var max_health := 1
@export var min_xp_drop := 1
@export var max_xp_drop := 3
@export var max_xp_value := 1
@export var min_group_size := 1
@export var max_group_size := 5

#var on_fire = false
#var freeze_time = 0.5
@export var hurt_color : Color
#@export var freeze_color : Color

var active = false
var current_health := 1

func _ready():
	current_health = max_health

func _physics_process(delta):
	face_player()

func face_player():
	if global_position.x - player.global_position.x > 0:
		$Sprite.flip_h = false
	else:
		$Sprite.flip_h = true

func get_hit(is_crit, dir):
	if is_crit:
		current_health -= 3
	else:
		current_health -= 1
	
	AudioManager.play_sfx(hurt_sfx, 1.0, 0.5)
	
	velocity = dir * 50.0
	
	$Sprite.material.set_shader_parameter("input_color", hurt_color)
	$Sprite.material.set_shader_parameter("active", true)
	self.set_physics_process(false)
	await get_tree().create_timer(0.05, false).timeout
	self.set_physics_process(true)
	$Sprite.material.set_shader_parameter("active", false)
	
	if current_health <= 0:
		die(dir)

#func freeze():
	#var anim = null
	#for i in get_children():
		#if i is AnimationPlayer:
			#anim = i
	#
	#if anim != null:
		#anim.speed_scale = 0
	#
	#$Sprite.material.set_shader_parameter("input_color", freeze_color)
	#$Sprite.material.set_shader_parameter("active", true)
	#self.set_physics_process(false)
	#await get_tree().create_timer(freeze_time, false).timeout
	#self.set_physics_process(true)
	#$Sprite.material.set_shader_parameter("active", false)
	#
	#if anim != null:
		#anim.speed_scale = 1

#func catch_fire():
	#if !on_fire:
		#on_fire = true
		#var f = fire_partices.instantiate()
		#call_deferred("add_child", f)
		#f.emitting = true
	#
	#await get_tree().create_timer(1.0, false).timeout
	#get_hit()
	#catch_fire()

func die(dir):
	await spawn_coins(dir)
	emit_signal("died")
	if OptionsManager.enemies_killed.has(enemy_name):
		OptionsManager.enemies_killed[enemy_name] += 1
	else:
		OptionsManager.enemies_killed[enemy_name] = 1
	
	queue_free()

func spawn_coins(dir):
	for i in randi_range(min_xp_drop, max_xp_drop):
		var c = coin.instantiate()
		world.connect_coin(c)
		c.global_position = global_position
		c.spawn_type = max_xp_value
		
		var angle = deg_to_rad(randf_range(-40.0, 40.0))
		dir = dir.normalized()
		c.direction = dir.rotated(angle)
		#c.vel = randf_range(2.5, 4.0)
		world.pickups.call_deferred("add_child", c)

func _on_hurtbox_area_entered(area):
	if area.get_collision_layer_value(4):
		if area.is_in_group("Player"):
			if area is Bullet:
				get_hit(area.is_crit, area.dir)
			elif area is Bomb or area is Friend:
				get_hit(false, -global_position.direction_to(area.global_position))
		
