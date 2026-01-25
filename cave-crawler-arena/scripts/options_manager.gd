extends Node

signal data_loaded

var save_path = "user://save_data.dat"

var enemies_killed = {
	"rat": 0,
	"crab": 0,
	"rolypoly": 0,
	"turret": 0,
	"bat": 0,
	"skull": 0,
	"miniboss1": 0,
	"fish": 0,
}

var options = {
	"volume_sfx": 5.0,
	"volume_music": 5.0,
}

func _ready() -> void:
	load_data()

func save_data():
	#print("SAVE CALLED FROM:", get_stack())
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	
	var data = {
		"options": options,
		"enemies_killed": enemies_killed,
	}
	
	#print(data)
	
	file.store_var(data)

func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		var load_data = file.get_var()
		
		#print(load_data)
		
		if load_data:
			if load_data.has("options"):
				options = load_data["options"]
			
			if load_data.has("enemies_killed"):
				enemies_killed = load_data["enemies_killed"]
	
	data_loaded.emit()

func set_enemies_killed(enemy_name : String):
	enemies_killed[enemy_name] += 1

func set_option(option, value):
	options[option] = value
	save_data()
