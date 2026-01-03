extends State


var dir := Vector2.LEFT

func enter():
	super.enter()
	entity.shots = 0

func physics_update(delta):
	super.physics_update(delta)
	entity.velocity = lerp(entity.velocity, Vector2.ZERO, entity.accel * delta)
	
	entity.shoot_bullet()
	
	if entity.shots >= 5:
		return entity.chase
