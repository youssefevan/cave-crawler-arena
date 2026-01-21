extends Enemy

func _ready():
	$Animator.play("fly")

func _physics_process(delta):
	super._physics_process(delta)
	
	var circling = (global_position - player.global_position).normalized().rotated(PI/2) * speed
	
	var encroach_speed = 8.0
	if global_position.distance_to(player.global_position) > 130.0:
		encroach_speed = 30.0
	else:
		encroach_speed = 8.0
	
	var move_in = global_position.direction_to(player.global_position) * encroach_speed
	velocity = circling + move_in
	
	move_and_slide()
