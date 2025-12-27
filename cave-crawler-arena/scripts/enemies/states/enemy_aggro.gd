extends State

func enter():
	super.enter()
	#entity.animator.play("Aggro")

func physics_update(delta):
	super.physics_update(delta)
	
	var dir = entity.global_position.direction_to(entity.player.global_position).normalized()
	
	entity.velocity = lerp(entity.velocity, dir * entity.speed, entity.accel * delta)
	
	if entity.player == null:
		return entity.idle
	
	var player_dist = entity.global_position.distance_to(entity.player.global_position)
	
	if player_dist <= entity.lunge_distance:
		return entity.lunge
