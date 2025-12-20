extends Enemy
class_name Rat

@onready var animator : AnimationPlayer = $Animator

@onready var state_manager : StateManager = $StateManager
@onready var idle : State = $StateManager/Idle
@onready var aggro : State = $StateManager/Aggro
@onready var lunge : State = $StateManager/Lunge
@onready var cooldown : State = $StateManager/Cooldown
@onready var melee : State = $StateManager/Melee

var aggro_distance := 70.0
var melee_distance := 10.0
var lunge_distance := 40.0
var lunge_strength := 200.0

func _ready():
	super._ready()
	state_manager.init(self)

func _physics_process(delta):
	super._physics_process(delta)
	state_manager.physics_update(delta)
	
	move_and_slide()
