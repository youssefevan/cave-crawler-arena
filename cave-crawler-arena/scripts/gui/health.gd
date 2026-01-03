extends VBoxContainer

func _physics_process(delta):
	$HPBar.max_value = Global.get_stat("max_health")
	$HPBar.value = Global.health
	$Label.text = str(
		max(0, int(Global.health)), "/",
		Global.get_stat("max_health")
	)
