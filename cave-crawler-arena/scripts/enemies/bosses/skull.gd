extends Boss
class_name Skull

var dir
var frame := 0

func _ready():
	super._ready()
	dir = global_position.direction_to(player.global_position).normalized()

func _physics_process(delta):
	super._physics_process(delta)
	frame += 1
	
	if frame % 5 == 0:
		dir = global_position.direction_to(player.global_position).normalized()
	
	velocity = lerp(velocity, dir * speed, accel * delta)
	
	move_and_slide()
