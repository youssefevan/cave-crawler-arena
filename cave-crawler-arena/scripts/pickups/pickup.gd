extends Area2D
class_name Pickup

signal collected

var direction := Vector2(0, 0)
var decay := 5.0
var vel := 50.0

var speed := 120.0

var within_range = false
var player : Player

func _ready():
	vel = randf_range(50.0, 70.0)
	
	choose_type()

func choose_type():
	pass

func _physics_process(delta):
	if player == null:
		vel = lerpf(vel, 0.0, decay * delta)
		global_position += direction * vel * delta
	else:
		if Global.health > 0:
			direction = global_position.direction_to(player.global_position)
			vel = lerpf(vel, speed, decay * delta)
			global_position += direction * vel * delta

func despawn():
	collected.emit()
	queue_free()

func _on_body_entered(body):
	if body is Player:
		despawn()
