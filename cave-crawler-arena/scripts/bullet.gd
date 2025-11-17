extends Area2D

var speed = 160.0
var expiration_timer := 0.5

func _ready():
	expiration_timer = 0.5
	await get_tree().create_timer(expiration_timer, false).timeout
	queue_free()

func _physics_process(delta):
	var dir = Vector2.RIGHT.rotated(rotation)
	global_position += dir * speed * delta

func _on_area_entered(area):
	if area.get_collision_layer_value(5) and area.is_in_group("Enemy"):
		queue_free()
