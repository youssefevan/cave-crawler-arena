extends State

var refresh_time := 0.2
var current_time := 0.0

var dir := Vector2.ZERO

func enter():
	super.enter()
	entity.animator.play("Move")

func physics_update(delta):
	super.physics_update(delta)
	
	current_time -= delta
	
	if current_time < refresh_time:
		var dist_to_player = entity.global_position.distance_squared_to(entity.player.global_position)
		
		if dist_to_player < pow(entity.aggro_range, 2):
			return entity.anticipate
		
		dir = entity.global_position.direction_to(entity.player.global_position)
		
		current_time = refresh_time
	
	entity.velocity = lerp(entity.velocity, dir * entity.speed, entity.accel * delta)
