extends Node

var save_path = "user://save_data.dat"

var enemies_killed = {
	"rat": 0,
	"crab": 0,
	"rolypoly": 0,
	"turret": 0,
	"bat": 0,
	"skull": 0,
	"miniboss1": 0,
}

func _ready() -> void:
	load_statss()

func save_stats():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	
	var data = {
		"enemies_killed": enemies_killed,
	}
	
	file.store_var(data)

func load_statss():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		var load_data = file.get_var()
		
		print(load_data)
		
		enemies_killed = load_data.enemies_killed

func set_enemies_killed(enemy_name : String):
	enemies_killed[enemy_name] += 1
