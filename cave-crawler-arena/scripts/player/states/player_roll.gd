extends State

var ended := false
var frame := 0 

func enter():
	super.enter()
	
	entity.roll_input_buffer = 0
	frame = 0
	
	ended = false
	entity.velocity = entity.input * entity.roll_speed
	
	if entity.input.x < 0:
		entity.sprite.flip_h = true
	elif entity.input.x > 0:
		entity.sprite.flip_h = false

func physics_update(delta):
	super.physics_update(delta)
	
	frame += 1
	
	if frame >= 30:
		frame = 0
		ended = true
	
	entity.velocity = lerp(entity.velocity, Vector2.ZERO, entity.roll_decel * delta)
	
	if ended:
		return entity.idle

func exit():
	super.exit()
