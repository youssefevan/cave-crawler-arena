extends Enemy
class_name Boss

@export var max_health = 20.0

func _ready():
	health = max_health
	super._ready()

func _physics_process(delta):
	super._physics_process(delta)
	%HealthBar.value = int((health/max_health) * 100)

func spawn_coin():
	var c = coin.instantiate()
	get_parent().get_parent().connect_coin(c)
	c.global_position = global_position
	c.spawn_type = max_xp_value
	c.vel = 5.0
	get_parent().get_parent().pickups.add_child(c)
