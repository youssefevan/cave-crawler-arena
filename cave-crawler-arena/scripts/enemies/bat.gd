extends Enemy

func _ready():
	super._ready()
	$Animator.play("fly")

func _physics_process(delta):
	super._physics_process(delta)
	
	var encroach_speed = 30.0
	
	#if global_position.distance_squared_to(player.global_position) > (130.0*130.0):
		#encroach_speed = 30.0
	
	var circling = (global_position - player.global_position).normalized().rotated(PI/2) * speed
	
	var move_in = global_position.direction_to(player.global_position) * encroach_speed
	velocity = lerp(velocity, circling + move_in, 5.0 * delta)
	
	move_and_slide()
