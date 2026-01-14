extends Button
class_name ShopButton

var selection

func _ready():
	connect("pressed", _on_shop_button_pressed)

func update(choice : String):
	selection = choice
	
	match selection:
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
		"bullet_life":
			text = "+attack range"
			icon = preload("res://sprites/upgrades/bullet_life.png")
		"bullet_size":
			text = "+attack size"
			icon = preload("res://sprites/upgrades/bullet_size.png")
		"max_health":
			text = "+max health"
			icon = preload("res://sprites/upgrades/max_health.png")
		"heal_aura":
			text = "heal aura"
			icon = preload("res://sprites/items/heal_aura.png")
		"splitshot":
			text = "splitshot"
			icon = preload("res://sprites/items/splitshot.png")
		"flamedash":
			text = "flamedash"
			icon = preload("res://sprites/items/flamedash.png")
		"skull_friend":
			text = "skull friend"
			icon = preload("res://sprites/items/skull_friend.png")
		"bomb":
			text = "bomb"
			icon = preload("res://sprites/items/bomb.png")
		_:
			text = selection
			icon = preload("res://sprites/items/empty.png")

func _on_shop_button_pressed():
	if Global.level % 5 != 0:
		Global.level_up_stat(selection)
	else:
		Global.level_up_item(selection)
