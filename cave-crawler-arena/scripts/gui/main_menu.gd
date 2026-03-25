extends Control

@onready var options = preload("res://scenes/gui/options_menu.tscn")

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_options_pressed():
	var o = options.instantiate()
	add_child(o)
