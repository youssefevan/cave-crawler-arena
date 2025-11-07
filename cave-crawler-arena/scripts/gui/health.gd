extends VBoxContainer

func _physics_process(delta):
	$HPBar.value = max(0, Global.player_stats["health"]/Global.player_stats["maxhp"] * 100)
	$Label.text = str(
		max(0, int(Global.player_stats["health"])), "/",
		int(Global.player_stats["maxhp"])
	)
