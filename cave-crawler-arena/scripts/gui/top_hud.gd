extends VBoxContainer

@export var world : Node2D

# messy messy messy
# messy messy messy
# messy messy messy
# messy messy messy
func _physics_process(delta):
	$XPBar.value = Global.xp/Global.get_xp_to_level() * 100
	
	$Stats/LVL.text = str("LVL ", Global.level, ": ", int(Global.xp), "/", int(Global.get_xp_to_level()))
	
	$Stats/Wave.text = str("Wave: ", world.wave)
	
	var minutes = floori(world.run_timer.time_left/60.0)
	var seconds = int(world.run_timer.time_left) % 60
	$Stats/Timer.text = "%02d:%02d" % [minutes, seconds]
	
	if world.run_timer.time_left <= 31.0:
		if int(world.run_timer.time_left) % 2 == 0:
			$Stats/Timer.add_theme_color_override("font_color", Color.RED)
		else:
			$Stats/Timer.add_theme_color_override("font_color", Color.WHITE)
