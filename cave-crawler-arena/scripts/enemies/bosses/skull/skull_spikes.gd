extends State

var done := false

func enter():
	super.enter()
	done = false
	await get_tree().create_timer(randf_range(4.0, 8.0), false).timeout
	done = true

func physics_update(delta):
	super.physics_update(delta)
	
	entity.dir = entity.global_position.direction_to(entity.player.global_position).normalized()
	
	entity.velocity = lerp(entity.velocity, entity.dir * (entity.speed/2.0), entity.accel * delta)
	
	entity.handle_spikes()
	
	if done:
		return entity.chase
