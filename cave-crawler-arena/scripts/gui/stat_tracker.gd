extends VBoxContainer

@export var stat_name = ""

func update_stat():
	$Counter.text = ""
	for i in range(int(Global.stats[stat_name][1])):
		$Counter.text += "|"
