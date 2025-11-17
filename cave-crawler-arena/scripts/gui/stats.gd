extends VBoxContainer

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
	%Level.text = str("Level: ", int(Global.level))
	%Multi.text = str("+", int(Global.level), "% on base stats")
	
	for i in %StatIcons.get_children():
		i.update_stat()
