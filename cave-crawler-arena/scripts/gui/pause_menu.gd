extends Control

func _ready():
	visible = false

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		visible = !visible
		get_tree().paused = !get_tree().paused
		update_info()

func update_info():
	$Content/BG/Info/Stats.text = str(Global.stats)
	$Content/BG/Info/Items.text = str(Global.items)

func _on_quit_pressed():
	OptionsManager.save_data()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/gui/main_menu.tscn")
