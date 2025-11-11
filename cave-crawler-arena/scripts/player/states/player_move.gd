extends State
class_name PlayerMove

func enter():
	super.enter()
	entity.animator.play("move")

func physics_update(delta):
	super.physics_update(delta)
	
	entity.handle_input()
	entity.handle_aim()
	
	if entity.input.x < 0:
		entity.sprite.flip_h = true
	if entity.input.x > 0:
		entity.sprite.flip_h = false
	
	entity.velocity = lerp(entity.velocity, entity.speed * entity.input, entity.accel * delta)
	
	if entity.input == Vector2.ZERO:
		return entity.idle
	
	if int(Global.health) <= 0:
		return entity.die
