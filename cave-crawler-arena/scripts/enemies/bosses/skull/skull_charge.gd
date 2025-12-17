extends State

var start := false
var stop := false
var done := false
var dir : Vector2

func enter():
	super.enter()
	
	done = false
	stop = false
	start = false
	await get_tree().create_timer(0.5, false).timeout
	
	dir = entity.dir
	start = true
	await get_tree().create_timer(0.75, false).timeout
	stop = true
	
	await get_tree().create_timer(0.5, false).timeout
	done = true

func physics_update(delta):
	super.physics_update(delta)
	
	if start and !stop:
		entity.velocity = lerp(entity.velocity, dir * entity.speed * 5.0, entity.accel * delta)
	else:
		entity.velocity = lerp(entity.velocity, Vector2.ZERO, entity.accel * delta)
	
	if done:
		return entity.chase
