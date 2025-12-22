extends State

var frame := 0

func enter():
	frame = 0

func physics_update(delta):
	super.physics_update(delta)
	
	frame += 1
	
	if frame % 5 == 0:
		var dir = entity.global_position.direction_to(entity.player.global_position)
		entity.velocity = lerp(entity.velocity, dir * entity.speed, entity.accel * delta)
	
	if entity.global_position.distance_to(entity.player.global_position) < 80.0 and frame >= 60*3:
		return entity.shoot
