extends Enemy

var frame := 0
var dir

func _ready():
	dir = global_position.direction_to(player.global_position).normalized()
	$Animator.play("move")

func _physics_process(delta):
	super._physics_process(delta)
	frame += 1
	
	if frame % 5 == 0:
		dir = global_position.direction_to(player.global_position).normalized()
	
	velocity = lerp(velocity, dir * speed, accel * delta)
	
	move_and_slide()

func face_player():
	pass

func die():
	super.die()
