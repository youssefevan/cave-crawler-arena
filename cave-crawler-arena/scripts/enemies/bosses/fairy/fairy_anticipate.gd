extends State

var time := 2.0

func enter():
	super.enter()
	time = 2.0
	entity.animator.play("Anticipate")

func physics_update(delta):
	super.physics_update(delta)
	entity.velocity = lerp(entity.velocity, Vector2.ZERO, entity.accel * delta)
	
	time -= delta
	
	if time < 0.0:
		return entity.attack
