extends VBoxContainer

func _physics_process(delta):
	$XPBar.value = Global.player_stats["xp"]/Global.get_xp_to_level() * 100
	$Stats/XP.text = str(
		int(Global.player_stats["xp"]), "/",
		int(Global.get_xp_to_level())
	)
	$Stats/LVL.text = str("LVL ", Global.player_stats["level"], ":")
