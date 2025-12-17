extends State

var frame := 0
var last_attack = null

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
		var attacks = [entity.shoot, entity.spikes, entity.charge]
		var next_attack = attacks.pick_random()
		
		if last_attack != null:
			while next_attack == last_attack:
				next_attack = attacks.pick_random()
		
		last_attack = next_attack
		return next_attack
