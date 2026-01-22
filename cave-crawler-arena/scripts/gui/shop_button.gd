extends Button
class_name ShopButton

var selection
var type := "stat"

func _ready():
	connect("pressed", _on_shop_button_pressed)

func update(choice : String):
	selection = choice
	
	# replace with dictionary
	match selection:
		"speed":
			type = "stat"
			text = "+movement speed"
			icon = preload("res://sprites/upgrades/speed.png")
		"firerate":
			type = "stat"
			text = "+firerate"
			icon = preload("res://sprites/upgrades/firerate.png")
		"regen_rate":
			type = "stat"
			text = "+health regen rate"
			icon = preload("res://sprites/upgrades/regen.png")
		"pickup_range":
			type = "stat"
			text = "+pickup range"
			icon = preload("res://sprites/upgrades/reach.png")
		"bullet_life":
			type = "stat"
			text = "+attack range"
			icon = preload("res://sprites/upgrades/bullet_life.png")
		"bullet_size":
			type = "stat"
			text = "+bullet size"
			icon = preload("res://sprites/upgrades/bullet_size.png")
		"max_health":
			type = "stat"
			text = "+40 max health"
			icon = preload("res://sprites/upgrades/max_health.png")
		"crit_chance":
			type = "stat"
			text = "+6% crit chance"
			icon = preload("res://sprites/upgrades/crit_chance.png")
		"heal_aura":
			type = "item"
			text = "heal aura"
			icon = preload("res://sprites/items/heal_aura.png")
		"splitshot":
			type = "item"
			text = "splitshot"
			icon = preload("res://sprites/items/splitshot.png")
		"skull_friend":
			type = "item"
			text = "friend"
			icon = preload("res://sprites/items/skull_friend.png")
		"bomb":
			type = "item"
			text = "bomb"
			icon = preload("res://sprites/items/bomb.png")
		_:
			text = "null"
			icon = preload("res://sprites/items/empty.png")

func _on_shop_button_pressed():
	if type == "stat":
		Global.level_up_stat(selection)
	elif type == "item":
		Global.level_up_item(selection)
	else:
		print("Error: upgrade type ", type, " not found...")
