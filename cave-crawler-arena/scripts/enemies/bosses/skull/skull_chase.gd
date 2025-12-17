extends State

var frame := 0

func enter():
	super.enter()
	frame = 0

func physics_update(delta):
	super.physics_update(delta)
	
	frame += 1
	
	if frame % 5 == 0:
		entity.dir = entity.global_position.direction_to(entity.player.global_position).normalized()
	
	entity.velocity = lerp(entity.velocity, entity.dir * entity.speed, entity.accel * delta)
	
	if entity.global_position.distance_to(entity.player.global_position) < 100 and frame > 60*3:
		var next_state = randi_range(0, 1)
		
		match next_state:
			0:
				return entity.shoot
			1:
				return entity.spikes
