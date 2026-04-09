extends Hitbox
class_name EnemyBullet

@export var speed = 70.0
@export var expiration_timer = 2.0

var target_group = "Player"
var dir
@onready var sprite = $Sprite

func _ready():
	dir = Vector2.RIGHT.rotated(rotation)
	await get_tree().create_timer(expiration_timer, false).timeout
	queue_free()

func _physics_process(delta):
	global_position += dir * speed * delta

func _on_area_entered(area):
	if area.get_collision_layer_value(5) and area.is_in_group(target_group):
		queue_free()
