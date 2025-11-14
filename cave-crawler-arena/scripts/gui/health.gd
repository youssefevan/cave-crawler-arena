extends VBoxContainer

func _physics_process(delta):
	$HPBar.value = max(0, (float(Global.health)/100.0) * 100)
	$Label.text = str(
		max(0, int(Global.health)), "/",
		int(100.0)
	)
