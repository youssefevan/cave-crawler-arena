extends Boss
class_name Skull

@onready var state_manager = $StateManager

func _ready():
	super._ready()
	
	state_manager.init(self)

func _physics_process(delta):
	super._physics_process(delta)
	state_manager.physics_update(delta)
	
	move_and_slide()
