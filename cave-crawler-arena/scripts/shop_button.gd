extends Button
class_name ShopButton

@export var stat_upgrade := ""
@export var upgrade_increment := 1.0
@export var upgrade_scaling_type := "linear"
@export var scales_up := true

func _ready():
	connect("pressed", buy)

func _physics_process(_delta):
	# dont look its hideous
	if Global.player_stat_limits[stat_upgrade] != -1:
		if scales_up == true:
			if upgrade_scaling_type == "linear":
				if Global.player_stat_limits[stat_upgrade] < Global.player_stats[stat_upgrade] + upgrade_increment:
					disabled = true
			else:
				if Global.player_stat_limits[stat_upgrade] < Global.player_stats[stat_upgrade] * upgrade_increment:
					disabled = true
		else:
			if upgrade_scaling_type == "linear":
				if Global.player_stat_limits[stat_upgrade] > Global.player_stats[stat_upgrade] + upgrade_increment:
					disabled = true
			else:
				if Global.player_stat_limits[stat_upgrade] > Global.player_stats[stat_upgrade] * upgrade_increment:
					disabled = true

func buy():
	if upgrade_scaling_type == "linear":
		Global.player_stats[stat_upgrade] += upgrade_increment
	elif upgrade_scaling_type == "multiplier":
		Global.player_stats[stat_upgrade] *= upgrade_increment
