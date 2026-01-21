extends Enemy
class_name Boss

func _ready():
	super._ready()
	%HealthBar.max_value = max_health

func _physics_process(delta):
	super._physics_process(delta)
	%HealthBar.value = current_health

func spawn_coin():
	var c = coin.instantiate()
	world.connect_coin(c)
	c.global_position = global_position
	c.spawn_type = max_xp_value
	c.vel = 5.0
	world.pickups.add_child(c)
