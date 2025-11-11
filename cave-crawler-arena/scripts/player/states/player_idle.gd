extends State

func enter():
	super.enter()
	entity.animator.play("idle")

func physics_update(delta):
	super.physics_update(delta)
	
	entity.handle_input()
	entity.handle_aim()
	
	entity.velocity = lerp(entity.velocity, Vector2.ZERO, entity.decel * delta)
	
	if entity.input != Vector2.ZERO:
		return entity.move
	
	if int(Global.health) <= 0:
		return entity.die
