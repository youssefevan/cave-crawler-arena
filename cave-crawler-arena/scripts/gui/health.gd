extends VBoxContainer

func _physics_process(delta):
	$HPBar.value = max(0, (float(Global.health)/float(Global.get_stat("maxhp"))) * 100)
	$Label.text = str(
		max(0, int(Global.health)), "/",
		int(Global.get_stat("maxhp"))
	)
