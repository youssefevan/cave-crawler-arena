extends State

var timer = 45
var frame = 0

func enter():
	super.enter()
	timer = 45
	frame = 0
	#entity.animator.play("Cooldown")
	var player_dist = entity.global_position.distance_to(entity.player.global_position)
	if player_dist <= entity.melee_distance:
		timer = 15

func physics_update(delta):
	super.physics_update(delta)
	frame += 1
	
	entity.velocity = lerp(entity.velocity, Vector2.ZERO, entity.accel * delta)
	
	if frame >= timer:
		return entity.idle
