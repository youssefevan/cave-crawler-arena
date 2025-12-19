extends Pickup
class_name Coin

var value := 1
var spawn_type := 1

@onready var pickup_sfx = preload("res://audio/xp2.ogg")

func _ready():
	super._ready()
	
	await get_tree().create_timer(60.0, false).timeout
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

func despawn():
	Global.xp += value
	var pitch = 0.5 + (Global.xp/Global.get_xp_to_level())
	AudioManager.play_sfx(pickup_sfx, pitch, 0.1)
	super.despawn()
