extends VBoxContainer

func _ready():
	close()

func _physics_process(delta):
	if Input.is_action_just_pressed("pause") and Global.health > 0:
		if !visible:
			open()
		else:
			close()

func open():
	visible = true
	OptionsManager.save_stats()
	get_tree().paused = true
	
	update_stats()

func close():
	visible = false
	get_tree().paused = false

func update_stats():
	if Global.health > 0:
		%Level.text = str("Level: ", int(Global.level))
	else:
		%Level.text = str("Youd died!\nLevel: ", int(Global.level))
	%Multi.text = str("+", int(Global.level), "% on base stats")
	
	for i in %StatIcons.get_children():
		i.update_stat()


func _on_quit_pressed():
	Engine.time_scale = 1.0
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
