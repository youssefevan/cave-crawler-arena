extends Area2D
class_name Bullet

@onready var explosion = preload("res://scenes/hazards/explosion.tscn")

var speed = 160.0
var expiration_timer := 0.5

func _ready():
	await get_tree().create_timer(expiration_timer, false).timeout
	queue_free()

func _physics_process(delta):
	var dir = Vector2.RIGHT.rotated(rotation)
	global_position += dir * speed * delta

func _on_area_entered(area):
	if area.get_collision_layer_value(5) and area.is_in_group("Enemy"):
		if Global.equipped_item == "bomb":
			var e = explosion.instantiate()
			e.global_position = global_position
			get_parent().call_deferred("add_child", e)
		queue_free()
