extends Enemy
class_name Boss

@export var max_health = 20.0

func _ready():
	health = max_health
	super._ready()

func _physics_process(delta):
	%HealthBar.value = int((health/max_health) * 100)
