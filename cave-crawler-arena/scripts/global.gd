extends Node

var player_stats := {
	"health": 100.0,
	"xp": 0,
	"level": 1,
	"speed": 30.0,
	"firerate": 1.0,
	"bullet_speed": 80.0,
	"atksze": 1.0,
	"atktime": 0.4,
	"pickup_range": 8.0,
	"maxhp": 100.0,
	"regen": 0.1,
	"regen_rate": 2.0,
}

var player_stat_limits := {
	"health": 999,
	"xp": -1,
	"level": -1,
	"speed": 100.0,
	"firerate": 0.05,
	"bullet_speed": 400.0,
	"atksze": 4.0,
	"atktime": 2.0,
	"pickup_range": -1,
	"maxhp": -1,
	"regen": 4.0,
	"regen_rate": 0.1,
}

# packedscene, wave unlocked
var enemy_pool = {
	preload("res://scenes/enemies/crab.tscn"): 1,
	preload("res://scenes/enemies/rat.tscn"): 5,
	preload("res://scenes/enemies/roly_poly.tscn"): 10,
}

var day := 1
var wave := 1

func get_xp_to_level():
	var level = Global.player_stats["level"]
	return floor(pow(10 * level, 1.1))
