extends Pickup
class_name Upgrade

var stat = ""

func choose_type():
	var available_stats = []
	
	for i in Global.stats:
		if Global.stats[i][1] < 12:
			available_stats.append(i)
	
	if available_stats.is_empty():
		queue_free()
	
	stat = available_stats.pick_random()
	
	print(stat)
	
	match stat:
		"speed":
			$Sprite.frame = 0
		"firerate":
			$Sprite.frame = 1
		"regen_rate":
			$Sprite.frame = 2
		"pickup_range":
			$Sprite.frame = 3

func despawn():
	Global.stats[stat][1] += 1
	
	super.despawn()
