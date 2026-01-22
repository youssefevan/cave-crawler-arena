extends Hitbox
class_name EnemyBullet

@export var speed = 70.0
@export var expiration_timer = 2.0

func _ready():
	await get_tree().create_timer(expiration_timer, false).timeout
	queue_free()

func _physics_process(delta):
	var dir = Vector2.RIGHT.rotated(rotation)
	global_position += dir * speed * delta

func _on_area_entered(area):
	if area.get_collision_layer_value(5) and area.is_in_group("Player"):
		queue_free()
