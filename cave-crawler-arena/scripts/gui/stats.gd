extends Panel

func _ready():
	close()

func _physics_process(delta):
	if Input.is_action_just_pressed("pause"):
		if !visible:
			open()
		else:
			close()

func open():
	visible = true
	get_tree().paused = true
	
	update_stats()

func close():
	visible = false
	get_tree().paused = false

func update_stats():
	$Stats/Level.text = str("Level: ", int(Global.level))
	$Stats/Multi.text = str("+", int(Global.level), "% on base stats")
	
	$Stats/StatIcons/Speed/Counter.text = ""
	for i in range(int(Global.stats["speed"][1])):
		$Stats/StatIcons/Speed/Counter.text += "+"
	
	$Stats/StatIcons/Firerate/Counter.text = ""
	for i in range(int(Global.stats["firerate"][1])):
		$Stats/StatIcons/Firerate/Counter.text += "+"
	
	$Stats/StatIcons/Regen/Counter.text = ""
	for i in range(int(Global.stats["regen_rate"][1])):
		$Stats/StatIcons/Regen/Counter.text += "+"
	
	$Stats/StatIcons/Reach/Counter.text = ""
	for i in range(int(Global.stats["pickup_range"][1])):
		$Stats/StatIcons/Reach/Counter.text += "+"
	#
	#$StatLevels/Firerate.text = str(int(Global.stats["firerate"][1]))
	#
	#$StatLevels/Regen.text = str(int(Global.stats["regen_rate"][1]))
	#
	#$StatLevels/PickupRange.text = str(int(Global.stats["pickup_range"][1]))
