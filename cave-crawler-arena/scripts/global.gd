extends Node

# packedscene, wave unlocked, spawn chance
var enemy_pool = {
	preload("res://scenes/enemies/crab.tscn"): [1, 0.4],
	preload("res://scenes/enemies/rat.tscn"): [4, 0.2],
	preload("res://scenes/enemies/roly_poly.tscn"): [12, 0.1],
	preload("res://scenes/enemies/turret.tscn"): [8, 0.1],
	preload("res://scenes/enemies/bat.tscn"): [10, 0.2],
}

var mini_boss_pool = [
	preload("res://scenes/enemies/bosses/miniboss_1.tscn"),
]

# base value, current level
var stats := {
	"speed": [38.0, 0],
	"firerate": [0.8, 0],
	"pickup_range": [8.0, 0],
	"regen_rate": [3.0, 0],
}

var max_stat_level = 8

var health = 100
var xp = 0
var level = 1

var equipped_item = null

func get_xp_to_level() -> float:
	return 20.0*level
	#return floor(pow(10 * level, 1.1))

func get_stat(stat : String):
	if stats[stat][1] == 0:
		return stats[stat][0]
	
	match stat:
		"speed":
			return stats["speed"][0] * pow(1.1, stats["speed"][1]) * (1+(level/100))
		"firerate":
			return stats["firerate"][0] * pow(0.8, stats["firerate"][1]) * (1+(level/100))
		"pickup_range":
			return stats["pickup_range"][0] * pow(1.3, stats["pickup_range"][1]) * (1+(level/100))
		"regen_rate":
			return stats["regen_rate"][0] * pow(0.8, stats["regen_rate"][1]) * (1-(level/100))
