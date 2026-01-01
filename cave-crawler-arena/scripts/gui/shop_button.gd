extends Button
class_name ShopButton

var item

func _ready():
	connect("pressed", _on_shop_button_pressed)

func update(choice : String):
	item = choice
	
	match item:
		"speed":
			text = "+movement speed"
			icon = preload("res://sprites/upgrades/speed.png")
		"firerate":
			text = "+firerate"
			icon = preload("res://sprites/upgrades/firerate.png")
		"regen_rate":
			text = "+health regen rate"
			icon = preload("res://sprites/upgrades/regen.png")
		"pickup_range":
			text = "+pickup range"
			icon = preload("res://sprites/upgrades/reach.png")
		_:
			text = item
			icon = preload("res://sprites/items/empty.png")

func _on_shop_button_pressed():
	Global.level_up_stat(item)
