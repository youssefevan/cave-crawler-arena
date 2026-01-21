extends Node

# packedscene, wave unlocked, spawn chance
var enemy_pool = {
	preload("res://scenes/enemies/crab.tscn"): [1, 1.0],
	preload("res://scenes/enemies/rat.tscn"): [4, 1.0],
	preload("res://scenes/enemies/roly_poly.tscn"): [16, 1.0],
	preload("res://scenes/enemies/turret.tscn"): [12, 1.0],
	preload("res://scenes/enemies/bat.tscn"): [8, 1.0],
}

var mini_boss_pool = [
	preload("res://scenes/enemies/bosses/miniboss_1.tscn"),
]

# base value, current level
var stats := {
	"speed": [38.0, 0],
	"firerate": [1.5, 0],
	"pickup_range": [8.0, 0],
	"regen_rate": [3.0, 0],
	"max_health": [300, 0],
	"bullet_size": [1.0, 0],
	"bullet_life": [0.2, 0],
}

var items := {
	"splitshot": 0,
	"skull_friend": 0,
	"heal_aura": 0,
	"flamedash": 0,
	"bomb": 0,
}

var max_stat_level = 8
var max_item_level = 4

var health = 100
var xp = 0
var level = 1

func get_xp_to_level() -> float:
	return 20.0*level
	#return floor(pow(10 * level, 1.1))

func level_up_stat(stat : String):
	stats[stat][1] += 1
	stats[stat][1] = min(stats[stat][1], max_stat_level)

func level_up_item(item : String):
	items[item] += 1
	items[item] = min(items[item], max_item_level)

func get_stat(stat : String):
	if stats[stat][1] == 0:
		return stats[stat][0]
	
	match stat:
		"speed":
			return stats[stat][0] * pow(1.1, stats[stat][1])
		"firerate":
			return stats[stat][0] - ((1.0/6.0) * stats[stat][1])
		"pickup_range":
			return stats[stat][0] + (8.0 * stats[stat][1])
		"regen_rate":
			return stats[stat][0] * pow(0.8, stats[stat][1])
		"bullet_size":
			return 1 + (stats[stat][1] * 0.3)
		"bullet_life":
			return stats[stat][0] + (stats[stat][1] * 0.05)
		"max_health":
			return stats[stat][0] + (stats[stat][1] * 40)

func get_item(item : String):
	match item:
		"heal_aura":
			return items[item]
		"splitshot":
			return items[item]
		"bomb":
			if items[item] == 0:
				return 0
			else:
				return 2.5 - (items[item] * 0.5)
		"skull_friend":
			if items[item] == 0:
				return 0
			else:
				return (items[item] * 30.0) + 90.0
