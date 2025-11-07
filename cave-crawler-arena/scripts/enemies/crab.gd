extends Enemy
class_name Crab

func _ready():
	super._ready()
	$Animator.play("move")

func _physics_process(delta):
	var dir = global_position.direction_to(player.global_position).normalized()
	velocity = lerp(velocity, dir * speed, accel * delta)
	move_and_slide()
