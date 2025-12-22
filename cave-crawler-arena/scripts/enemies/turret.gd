extends Enemy

@onready var state_manager = $StateManager
@onready var chase = $StateManager/Chase
@onready var shoot = $StateManager/Shoot

@onready var bullet = preload("res://scenes/hazards/enemy_bullet.tscn")

func _ready():
	super._ready()
	
	state_manager.init(self)

func _physics_process(delta):
	super._physics_process(delta)
	state_manager.physics_update(delta)
	
	move_and_slide()
