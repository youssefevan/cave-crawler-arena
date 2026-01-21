extends State

var timer = 60
var frame = 0

func enter():
	super.enter()
	frame = 0
	timer = 60
	#entity.animator.play("Cooldown")

func physics_update(delta):
	super.physics_update(delta)
	frame += 1
	
	entity.velocity = lerp(entity.velocity, Vector2.ZERO, entity.accel * delta)
	
	if frame >= timer:
		return entity.lunge
