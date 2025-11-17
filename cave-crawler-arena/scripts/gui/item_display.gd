extends HBoxContainer

var item_info = {
	null: [
		"No item equipped",
		load("res://sprites/items/empty.png"),
		],
	"acid": [
		"Burns enemies who touch it",
		load("res://sprites/items/corrorsion.png")
		],
	"lightning": [
		"Bullets explode on hit",
		load("res://sprites/items/lightning.png")
		],
}

func _on_visibility_changed():
	$Icon.texture = item_info[Global.equipped_item][1]
	$Desc.text = item_info[Global.equipped_item][0]
