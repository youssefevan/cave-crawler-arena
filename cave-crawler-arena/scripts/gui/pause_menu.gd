extends Control

@onready var options = preload("res://scenes/gui/options_menu.tscn")

func _ready():
	visible = false

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		# messy messy messy
		if $"../Shop".visible == false:
			get_tree().paused = !get_tree().paused
		
		visible = !visible
		update_info()

func update_info():
	# messy messy messy
	$Content/BG/Info/Stats.text = str(Global.stats)
	$Content/BG/Info/Items.text = str(Global.items)

func _on_quit_pressed():
	#OptionsManager.save_data()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/gui/main_menu.tscn")


func _on_options_pressed():
	var o = options.instantiate()
	get_parent().add_child(o)
