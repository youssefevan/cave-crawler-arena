extends Enemy

@onready var state_manager = $StateManager
@onready var chase = $StateManager/Chase
@onready var shoot = $StateManager/Shoot

@onready var bullet = preload("res://scenes/hazards/enemy_bullet.tscn")

var shots := 0
var can_shoot := true

func _ready():
	super._ready()
	state_manager.init(self)

func _physics_process(delta):
	super._physics_process(delta)
	state_manager.physics_update(delta)
	
	move_and_slide()

func shoot_bullet():
	if can_shoot:
		shots += 1
		var b = bullet.instantiate()
		b.global_position = global_position
		b.rotation = (global_position.direction_to(player.global_position + (player.velocity/2))).angle()
		world.bullets.call_deferred("add_child", b)
		can_shoot = false
		await get_tree().create_timer(2.0, false).timeout
		can_shoot = true
