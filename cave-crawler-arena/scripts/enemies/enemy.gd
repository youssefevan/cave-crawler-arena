extends CharacterBody2D
class_name Enemy

signal died

@onready var coin : PackedScene = preload("res://scenes/pickups/coin.tscn")

var player : Player

var accel := 5.0
@export var speed := 30.0
@export var health := 1
@export var min_xp_drop := 1
@export var max_xp_drop := 3
@export var max_xp_value := 1
@export var min_group_size := 1
@export var max_group_size := 5

var freeze_time = 0.5
@export var freeze_color : Color

func _ready():
	player = get_parent().get_parent().player

func get_hit():
	health -= 1
	
	if health <= 0:
		die()

func freeze():
	var anim = null
	for i in get_children():
		if i is AnimationPlayer:
			anim = i
	
	if anim != null:
		anim.speed_scale = 0
	
	$Sprite.material.set_shader_parameter("input_color", freeze_color)
	$Sprite.material.set_shader_parameter("active", true)
	self.set_physics_process(false)
	await get_tree().create_timer(freeze_time, false).timeout
	self.set_physics_process(true)
	$Sprite.material.set_shader_parameter("active", false)
	
	if anim != null:
		anim.speed_scale = 1

func die():
	for i in randi_range(min_xp_drop, max_xp_drop):
		call_deferred("spawn_coin")
	emit_signal("died")
	call_deferred("queue_free")

func spawn_coin():
	var c = coin.instantiate()
	get_parent().get_parent().connect_coin(c)
	c.global_position = global_position
	c.spawn_type = max_xp_value
	get_parent().get_parent().pickups.add_child(c)

func _on_hurtbox_area_entered(area):
	if area.get_collision_layer_value(4):
		if area.is_in_group("Player"):
			if Global.equipped_item == "bomb":
				if area is Bullet:
					return
			
			get_hit()
