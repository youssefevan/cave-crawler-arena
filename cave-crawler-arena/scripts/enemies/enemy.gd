extends CharacterBody2D
class_name Enemy

signal died

@onready var coin : PackedScene = preload("res://scenes/coin.tscn")

var player : Player

var accel := 5.0
@export var speed := 30.0
@export var health := 1
@export var min_xp_drop := 1
@export var max_xp_drop := 3
@export var max_xp_value := 1

func _ready():
	player = get_parent().get_parent().player

func get_hit():
	health -= 1
	
	if health <= 0:
		die()

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
			get_hit()
