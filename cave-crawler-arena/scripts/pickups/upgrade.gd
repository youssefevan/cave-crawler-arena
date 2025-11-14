extends Pickup
class_name Upgrade

var stat = 0

func choose_type():
	stat = randi_range(0, 3)
	
	$Sprite.frame = stat

func despawn():
	match stat:
		0:
			Global.stats["speed"][1] += 1
		1:
			Global.stats["firerate"][1] += 1
		2:
			Global.stats["regen_rate"][1] += 1
		3:
			Global.stats["pickup_range"][1] += 1
	
	super.despawn()
