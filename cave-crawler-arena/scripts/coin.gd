extends Area2D
class_name Pickup

signal collected

var direction := Vector2(0, 0)
var decay := 5.0
var vel := 1.0

var value := 1
var spawn_type := 1

var within_range = false
var player : Player

func _ready():
	direction.x = randf_range(-1, 1)
	direction.y = randf_range(-1, 1)
	
	choose_type()
	
	await get_tree().create_timer(15, false).timeout
	if player == null:
		queue_free()

func choose_type():
	# you know it doesn't have to be like this...
	# this is just how it is, unfortunatly
	if spawn_type == 1:
		value = 1
		$Sprite.frame = 0
	elif spawn_type == 2:
		var chance = randf()
		if chance < 0.8:
			value = 1
			$Sprite.frame = 0
		else:
			value = 5
			$Sprite.frame = 1
	elif spawn_type == 3:
		var chance = randf()
		if chance < 0.7:
			value = 1
			$Sprite.frame = 0
		elif chance >= 0.7 and chance < 0.9:
			value = 5
			$Sprite.frame = 1
		else:
			value = 12
			$Sprite.frame = 2

func _physics_process(delta):
	if player == null:
		vel = lerpf(vel, 0.0, decay * delta)
		global_position += direction * vel
	else:
		direction = global_position.direction_to(player.global_position)
		vel = lerpf(vel, 5.0, decay * delta)
		global_position += direction * vel

func despawn():
	Global.player_stats["xp"] += value
	collected.emit()
	queue_free()

func _on_body_entered(body):
	if body is Player:
		despawn()
