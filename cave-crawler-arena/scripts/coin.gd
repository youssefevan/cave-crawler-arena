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
	var values = [1, 5, 12]
	var frames = [0, 1, 2]
	var weights = [0.7, 0.2, 0.1]
	var sliced_weights = weights.slice(0, spawn_type)
	
	var weight_sum = 0
	
	for j in range(sliced_weights.size()):
		weight_sum += weights[j]
		
	var rng = randf_range(0, weight_sum)
	var cumulative = 0.0
	var chosen_type = 0
	for j in range(sliced_weights.size()):
		cumulative += weights[j]
		if rng <= cumulative:
			value = values[j]
			$Sprite.frame = frames[j]
			break

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
