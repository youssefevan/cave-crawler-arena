extends Area2D
class_name Pickup

signal collected

var direction := Vector2(0, 0)
var decay := 5.0
var vel := 1.0

var within_range = false
var player : Player

func _ready():
	direction.x = randf_range(-1, 1)
	direction.y = randf_range(-1, 1)
	
	choose_type()

func choose_type():
	pass

func _physics_process(delta):
	if player == null:
		vel = lerpf(vel, 0.0, decay * delta)
		global_position += direction * vel
	else:
		direction = global_position.direction_to(player.global_position)
		vel = lerpf(vel, 5.0, decay * delta)
		global_position += direction * vel

func despawn():
	collected.emit()
	queue_free()

func _on_body_entered(body):
	if body is Player:
		despawn()
