extends HBoxContainer

var item_info = {
	null: [
		"No item equipped",
		load("res://sprites/items/empty.png"),
		],
	"fire": [
		"Bullets apply burn",
		load("res://sprites/items/fire.png")
		],
	"bomb": [
		"Bullets explode on hit",
		load("res://sprites/items/bomb.png")
		],
}

func _on_visibility_changed():
	$Icon.texture = item_info[Global.equipped_item][1]
	$Desc.text = item_info[Global.equipped_item][0]
