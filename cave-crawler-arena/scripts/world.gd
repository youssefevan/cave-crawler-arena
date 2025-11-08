extends Node2D

@export var player : Player

@onready var pickups = %Pickups
@onready var bullets = %Bullets
@onready var enemies = %Enemies
@onready var spawner = %SpawnPositions
@onready var spawn_path = %SpawnPath

@onready var shop = %Shop
@onready var shop_options = %OptionContainer

var spawning_wave := false

var wave := 0

var previous_wave_sizes = []

func _ready():
	close_shop()
	for i in shop_options.get_children():
		if i is ShopButton:
			i.connect("pressed", close_shop)
	start_wave()

func start_wave():
	if spawning_wave:
		return
	spawning_wave = true
	
	wave += 1
	print("wave: ", wave)
	await spawn_wave()
	spawning_wave = false

# oh my god oh my god oh my god oh my god oh my god
func spawn_wave():
	for i in range(5):
		var available_enemies = []
		var weights = []
		
		for j in Global.enemy_pool:
			if Global.enemy_pool[j][0] <= wave:
				available_enemies.append(j)
				weights.append(Global.enemy_pool[j][1])
		
		var good_spot = false
		var spawn_pos = Vector2.ZERO
		
		while not good_spot:
			var posx = randf_range(64, 1024-64)
			var posy = randf_range(64, 1024-64)
			
			if abs(posx-player.global_position.x) > 160 and abs(posy-player.global_position.y) > 90:
				if abs(posx-player.global_position.x) < 320 and abs(posy-player.global_position.y) < 180:
					spawn_pos = Vector2(posx, posy)
					good_spot = true
		
		var weight_sum = 0
		for j in weights:
			weight_sum += j
		
		var rng = randf_range(0, weight_sum)
		var cumulative = 0.0
		print(rng)
		var chosen_enemy = null
		for j in range(available_enemies.size()):
			cumulative += weights[j]
			if rng <= cumulative:
				chosen_enemy = available_enemies[j]
				break
		
		var enemy_type = chosen_enemy.instantiate()
		var group_size = randi_range(enemy_type.min_group_size, enemy_type.max_group_size+floor(wave/2))
		for j in range(group_size):
			var e = chosen_enemy.instantiate()
			e.global_position = spawn_pos
			enemies.add_child(e)
			e.connect("died", enemy_died)
			await get_tree().create_timer(0.1, false).timeout
		await get_tree().create_timer(randf_range(0.01, 0.5), false).timeout
		
	check_for_enemies()

func open_shop():
	shop.visible = true
	
	get_tree().paused = true

func close_shop():
	shop.visible = false
	get_tree().paused = false

func enemy_died():
	await get_tree().create_timer(0.5, true).timeout
	if spawning_wave == false:
		check_for_enemies()

func check_for_enemies():
	if enemies.get_child_count() == 0 and not spawning_wave:
		var waiting_period = randf_range(3, 7)
		await get_tree().create_timer(waiting_period, true).timeout
		start_wave()

func connect_coin(coin):
	coin.connect("collected", coin_collected)

func coin_collected():
	var level = Global.player_stats["level"]
	if Global.player_stats["xp"] >= Global.get_xp_to_level():
		open_shop()
		Global.player_stats["xp"] -= Global.get_xp_to_level()
		Global.player_stats["level"] += 1
