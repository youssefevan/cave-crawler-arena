extends Boss
class_name Skull

# states
@onready var state_manager = $StateManager
@onready var chase = $StateManager/Chase
@onready var shoot = $StateManager/Shoot
@onready var spikes = $StateManager/Spikes

# scenes
@onready var fireball = preload("res://scenes/hazards/fireball.tscn")
@onready var spikes_scene = preload("res://scenes/hazards/spikes.tscn")

var dir

var can_fire := true
var firerate := 1.0

var last_attack = []

func _ready():
	super._ready()
	dir = global_position.direction_to(player.global_position).normalized()
	state_manager.init(self)

func _physics_process(delta):
	super._physics_process(delta)
	state_manager.physics_update(delta)
	
	move_and_slide()

func handle_shooting():
	if can_fire:
		var f = fireball.instantiate()
		f.rotation = dir.angle()
		f.global_position = global_position
		get_parent().get_parent().call_deferred("add_child", f)
		
		can_fire = false
		await get_tree().create_timer(firerate, false).timeout
		can_fire = true

func handle_spikes():
	if can_fire:
		var s = spikes_scene.instantiate()
		s.global_position = player.global_position + (player.velocity / Vector2(2.0, 2.0))
		get_parent().get_parent().call_deferred("add_child", s)
		
		can_fire = false
		await get_tree().create_timer(firerate, false).timeout
		can_fire = true
