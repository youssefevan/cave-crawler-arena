extends Panel

func _ready():
	for i in $Items.get_children():
		if i is ShopButton:
			i.connect("pressed", close)

#func _process(delta):
	#if Input.is_action_just_pressed("pause"):
		#open()

func open(is_item_level : bool):
	randomize_choices(is_item_level)
	visible = true
	$Items/Choice1.grab_focus()
	get_tree().paused = true

func randomize_choices(is_item_level : bool):
	var choices
	
	if is_item_level:
		choices = Global.items.keys().duplicate()
	else:
		choices = Global.stats.keys().duplicate()
	
	for i in choices:
		if is_item_level:
			if Global.items[i] >= Global.max_stat_level:
				choices.erase(i)
		else:
			if Global.stats[i][1] >= Global.max_stat_level:
				choices.erase(i)
	
	for i in $Items.get_children():
		if i is ShopButton:
			var choice = choices.pick_random()
			choices.erase(choice)
			i.update(choice)

func close():
	get_tree().paused = false
	visible = false
