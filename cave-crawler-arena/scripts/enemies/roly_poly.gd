extends Enemy
class_name RolyPoly

func _ready():
	super._ready()
	accel = 0.5
	
	$Animator.play("roll")

func _physics_process(delta):
	var dir = global_position.direction_to(player.global_position).normalized()
	velocity = lerp(velocity, dir * speed, accel * delta)
	$Animator.speed_scale = velocity.length()/speed
	
	move_and_slide()
