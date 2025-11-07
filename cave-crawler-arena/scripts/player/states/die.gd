extends State

func enter():
	super.enter()
	entity.animator.play("die")

func physics_update(delta):
	super.physics_update(delta)
	entity.velocity = lerp(entity.velocity, Vector2.ZERO, entity.decel * delta)
