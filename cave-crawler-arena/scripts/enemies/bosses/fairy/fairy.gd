extends Boss

@onready var state_manager = $StateManager
@onready var move = $StateManager/Move
@onready var anticipate = $StateManager/Anticipate
@onready var attack = $StateManager/Attack
@onready var recover = $StateManager/Recover
@onready var animator = $Animator
@onready var ring = preload("res://scenes/hazards/ring.tscn")

@export var aggro_range := 50.0

func _ready():
	super._ready()
	state_manager.init(self)

func _physics_process(delta):
	super._physics_process(delta)
	state_manager.physics_update(delta)
	
	move_and_slide()

func spawn_ring():
	var r = ring.instantiate()
	r.target = player
	r.global_position = $RingSpawn.global_position
	world.bullets.add_child(r)
