extends Node2D

@export var player : Player

@onready var pickups = %Pickups
@onready var bullets = %Bullets
@onready var enemies = %Enemies

@onready var upgrade_scene = preload("res://scenes/pickups/upgrade.tscn")

@export var boss : PackedScene

var spawning_wave := false

var wave := 0
var previous_wave_sizes = []

var active_enemies := 0

@export var run_time := 900

func _ready():
	Engine.time_scale = 1.0
	player.connect("dead", player_died)
	
	$RunTimer.wait_time = run_time
	$RunTimer.start()
	
	await get_tree().create_timer(2.0, false).timeout
	start_wave()

func _physics_process(delta):
	var minutes = floori(%RunTimer.time_left/60.0)
	var seconds = int(%RunTimer.time_left) % 60
	$CanvasLayer/HUD/XP/Stats/Timer.text = "%02d:%02d" % [minutes, seconds]

func start_wave():
	if spawning_wave:
		return
	spawning_wave = true
	
	wave += 1
	
	if wave % 10 == 0 and $RunTimer.time_left > 30.0:
		spawn_mini_boss()
	
	await spawn_wave()
	spawning_wave = false

# oh my god oh my god oh my god oh my god oh my god
func spawn_wave():
	# enemies are spawned in groups throughout the wave
	print("--wave: ", wave, "--")
	
	var num_groups = randi_range(2, 3)
	
	print("groups: ", num_groups)
	
	for i in range(num_groups):
		var available_enemies = []
		var weights = []
		
		for j in Global.enemy_pool:
			if Global.enemy_pool[j][0] <= wave:
				available_enemies.append(j)
				weights.append(Global.enemy_pool[j][1])
		
		# totals the spawn chance weights in order to normailze the selection
		var weight_sum = 0
		for j in weights:
			weight_sum += j
		
		var rng = randf_range(0, weight_sum)
		var cumulative = 0.0
		
		var chosen_enemy = null
		for j in range(available_enemies.size()):
			cumulative += weights[j]
			if rng <= cumulative:
				chosen_enemy = available_enemies[j]
				break
		
		var enemy_type = chosen_enemy.instantiate()
		
		# each enemy has a unique min and max group size, so it needs to be
		# selected after the enemy type is known
		var group_size = randi_range(enemy_type.min_group_size,
			min(enemy_type.min_group_size + wave, enemy_type.max_group_size))
		
		print("enemy group [", enemy_type.name, "] | size: ", group_size)
		
		enemy_type.queue_free()
		
		for j in range(group_size):
			var enemy = chosen_enemy.instantiate()
			enemy.global_position = get_good_spot("enemy")
			enemy.world = self
			enemy.player = player
			enemy.connect("died", enemy_died)
			enemies.call_deferred("add_child", enemy)
			
			active_enemies += 1
			await get_tree().create_timer(0.1, false).timeout
		
		# delay spawning while there are too many enemies in scene
		while active_enemies > 400:
			await get_tree().create_timer(5.0, false).timeout
		
		await get_tree().create_timer(randf_range(0.01, 0.1)).timeout
	
	check_for_enemies()

func player_died():
	var tween = get_tree().create_tween()
	tween.tween_property(Engine, "time_scale", 0.2, 1.0).set_trans(Tween.TRANS_LINEAR)
	
	await get_tree().create_timer(2.0, false, false, true).timeout
	#$CanvasLayer/HUD/Info.open()

func enemy_died():
	active_enemies -= 1
	
	await get_tree().create_timer(0.5, true).timeout
	if spawning_wave == false:
		check_for_enemies()

func check_for_enemies():
	if active_enemies < wave*2 and not spawning_wave:
		var waiting_period = randf_range(3, 6)
		await get_tree().create_timer(waiting_period, true).timeout
		
		# start next wave if boss isn't about to spawn
		if $RunTimer.time_left > 20.0:
			start_wave()

func connect_coin(coin):
	coin.connect("collected", coin_collected)

func connect_upgrade(upgrade):
	upgrade.connect("upgrade_collected", upgrade_collected)

func coin_collected():
	if Global.xp >= Global.get_xp_to_level():
		#level_up.open()
		Global.xp -= Global.get_xp_to_level()
		Global.level += 1
		
		if Global.level % 5 == 0:
			spawn_upgrade()
		
		open_shop()

func spawn_mini_boss():
	var choice = Global.mini_boss_pool.pick_random()
	var mini = choice.instantiate()
	mini.world = self
	mini.player = player
	
	mini.global_position = get_good_spot("enemy")
	%Enemies.call_deferred("add_child", mini)

func spawn_boss():
	for i in enemies.get_children():
		if i is Enemy:
			i.die()
	
	var spawn_pos = get_good_spot("enemy")
	var b = boss.instantiate()
	b.global_position = spawn_pos
	b.world = self
	b.player = player
	%Enemies.call_deferred("add_child", b)

func open_shop():
	$CanvasLayer/HUD/Shop.open(false)

func spawn_upgrade():
	var spawn_pos = get_good_spot("upgrade")
	var u = upgrade_scene.instantiate()
	u.global_position = spawn_pos
	%Pickups.call_deferred("add_child", u)
	connect_upgrade(u)

func upgrade_collected():
	$CanvasLayer/HUD/Shop.open(true)

func get_good_spot(type : String):
	var good_spot = false
	var spawn_pos = Vector2.ZERO
	
	if type == "enemy":
		while not good_spot:
			var posx = randf_range(64, 2048-64)
			var posy = randf_range(64, 2048-64)
			
			var dist_to_player = Vector2(posx, posy).distance_to(player.global_position)
			
			if dist_to_player > 200 and dist_to_player < 600:
				spawn_pos = Vector2(posx, posy)
				good_spot = true
		
	elif type == "upgrade":
		while not good_spot:
			var posx = randf_range(128, 2048-128)
			var posy = randf_range(128, 2048-128)
			
			var dist_to_player = Vector2(posx, posy).distance_to(player.global_position)
			
			if dist_to_player > 200 and dist_to_player < 600:
				spawn_pos = Vector2(posx, posy)
				good_spot = true
	else:
		print(type, " type not supported")
	
	return spawn_pos

func _on_run_timer_timeout():
	spawn_boss()
