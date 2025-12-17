extends VBoxContainer

func _physics_process(delta):
	$HPBar.value = max(0, (float(Global.health)/50.0) * 50)
	$Label.text = str(
		max(0, int(Global.health)), "/",
		int(50.0)
	)
