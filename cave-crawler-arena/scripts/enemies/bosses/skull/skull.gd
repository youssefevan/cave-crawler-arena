extends Boss
class_name Skull

# states
@onready var state_manager = $StateManager
@onready var chase = $StateManager/Chase
@onready var shoot = $StateManager/Shoot
@onready var spikes = $StateManager/Spikes
@onready var charge = $StateManager/Charge

# scenes
@onready var fireball = preload("res://scenes/hazards/bone.tscn")
@onready var spikes_scene = preload("res://scenes/hazards/spikes.tscn")

var dir

var can_fire := true
var firerate := 0.2
var spikerate := 0.5

var aim := randf_range(0, 360)

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
		aim += 15.0
		f.rotation_degrees = aim
		f.global_position = global_position
		get_parent().get_parent().call_deferred("add_child", f)
		
		var f1 = fireball.instantiate()
		f1.rotation_degrees = -aim
		f1.global_position = global_position
		get_parent().get_parent().call_deferred("add_child", f1)
		
		can_fire = false
		await get_tree().create_timer(firerate, false).timeout
		can_fire = true

func handle_spikes():
	if can_fire:
		var s = spikes_scene.instantiate()
		s.global_position = player.global_position + (player.velocity / Vector2(3.0, 3.0))
		get_parent().get_parent().call_deferred("add_child", s)
		
		can_fire = false
		await get_tree().create_timer(spikerate, false).timeout
		can_fire = true
