extends Control

@onready var desc = %Title

func close():
	get_tree().paused = false
	visible = false

func open():
	get_tree().paused = true
	visible = true
	
	var available_stats = []
	for i in Global.stats:
		if Global.stats[i][1] < Global.max_stat_level:
			available_stats.append(i)
	
	if available_stats.is_empty():
		desc.text = "Level Up!\nAll stats max level!"
		return
	
	var stat_to_level = available_stats.pick_random()
	Global.stats[stat_to_level][1] += 1
	
	match stat_to_level:
		"speed":
			desc.text = "Level Up!\n+10% speed"
		"firerate":
			desc.text = "Level Up!\n+20% firerate"
		"bullet_speed":
			desc.text = "Level Up!\n+10% bullet vel"
		"bullet_size":
			desc.text = "Level Up!\n+20% bullet size"
		"maxhp":
			desc.text = "Level Up!\n+20 max hp"
		"regen_rate":
			desc.text = "Level Up!\n+20% hp/s"

func _on_confirm_pressed():
	close()
