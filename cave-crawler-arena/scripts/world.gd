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
	print("wave: ", wave)
	await spawn_wave()
	spawning_wave = false

# oh my god oh my god oh my god oh my god oh my god
func spawn_wave():
	# enemies are spawned in groups throughout the wave 
	var num_groups = randi_range(3+floori(wave/10.0), 5+floori(wave/4.0))
	
	for i in range(num_groups):
		var available_enemies = []
		var weights = []
		
		for j in Global.enemy_pool:
			if Global.enemy_pool[j][0] <= wave:
				available_enemies.append(j)
				weights.append(Global.enemy_pool[j][1])
		
		var spawn_pos = get_good_spot("enemy")
		
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
			min(enemy_type.min_group_size+floori(wave/2.0), enemy_type.max_group_size))
		
		for j in range(group_size):
			var e = chosen_enemy.instantiate()
			for group in enemies.get_children():
				if group.name == e.name:
					var enemy = null
					for k in group.get_children():
						if k.visible == false:
							enemy = k
							break
					
					enemy.respawn()
					enemy.global_position = spawn_pos
					active_enemies += 1
			
			await get_tree().create_timer(0.1, false).timeout
		
		# delay spawning while there are too many enemies in scene
		var enemies_in_scene = enemies.get_child_count()
		while enemies_in_scene > 200:
			await get_tree().create_timer(3.0, false).timeout
			enemies_in_scene = enemies.get_child_count()
		
		await get_tree().create_timer(randf_range(0.01, 0.5), false).timeout
	
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
	if active_enemies < wave and not spawning_wave:
		var waiting_period = randf_range(3, 6)
		await get_tree().create_timer(waiting_period, true).timeout
		
		# start next wave if boss isn't about to spawn
		if $RunTimer.time_left > 20.0:
			start_wave()

func connect_coin(coin):
	coin.connect("collected", coin_collected)

func coin_collected():
	if Global.xp >= Global.get_xp_to_level():
		#level_up.open()
		Global.xp -= Global.get_xp_to_level()
		Global.level += 1
		
		open_shop()
		
		if Global.level % 5 == 0 and $RunTimer.time_left > 30.0:
			spawn_mini_boss()

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
	%Enemies.call_deferred("add_child", b)

func open_shop():
	$CanvasLayer/HUD/Shop.open()

#func spawn_upgrade():
	#var spawn_pos = get_good_spot("upgrade")
	#var u = upgrade_scene.instantiate()
	#u.global_position = spawn_pos
	#%Pickups.call_deferred("add_child", u)

func get_good_spot(type : String):
	var good_spot = false
	var spawn_pos = Vector2.ZERO
	
	if type == "enemy":
		while not good_spot:
			var posx = randf_range(64, 1024-64)
			var posy = randf_range(64, 1024-64)
			
			if abs(posx-player.global_position.x) > 160 and abs(posy-player.global_position.y) > 90:
				if abs(posx-player.global_position.x) < 320 and abs(posy-player.global_position.y) < 180:
					spawn_pos = Vector2(posx, posy)
					good_spot = true
		
	elif type == "upgrade":
		while not good_spot:
			var posx = randf_range(64, 1024-64)
			var posy = randf_range(64, 1024-64)
			var chosen_pos = Vector2(posx, posy)
			
			if chosen_pos.distance_to(player.global_position) > 128:
				spawn_pos = chosen_pos
				good_spot = true
	else:
		print(type, " type not supported")
	
	return spawn_pos

func _on_run_timer_timeout():
	spawn_boss()
