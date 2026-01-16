extends State

func enter():
	super.enter()
	#entity.animator.play("Idle")

func physics_update(delta):
	super.physics_update(delta)
	entity.velocity = lerp(entity.velocity, Vector2.ZERO, entity.accel * delta)
	
	if entity.player != null:
		return entity.lunge
