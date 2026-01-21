extends Panel

func _ready():
	for i in $Items.get_children():
		if i is ShopButton:
			i.connect("pressed", close)

#func _process(delta):
	#if Input.is_action_just_pressed("pause"):
		#open(false)

func open(is_item : bool):
	randomize_choices(is_item)
	visible = true
	$Items/Choice1.grab_focus()
	get_tree().paused = true

func randomize_choices(is_item : bool):
	var choices = []
	
	if is_item:
		choices = Global.items.keys().duplicate()
	else:
		choices = Global.stats.keys().duplicate()
	
	# remove upgrade if maxed out
	for idx in range(choices.size() - 1, -1, -1):
		var i = choices[idx]
		
		if is_item:
			if Global.items[i] >= Global.max_item_level:
				choices.remove_at(idx)
		else:
			if Global.stats[i][1] >= Global.max_stat_level:
				choices.remove_at(idx)
	
	for i in $Items.get_children():
		if i is ShopButton:
			if choices.size() > 0:
				var choice = choices.pick_random()
				choices.erase(choice) # prevent duplicate choices
				i.update(choice)
			else:
				i.update("null")

func close():
	get_tree().paused = false
	visible = false
