extends State

var timer = 60*1
var frame = 0

func enter():
	super.enter()
	entity.animator.play("lunge")
	frame = 0

func physics_update(delta):
	super.physics_update(delta)
	frame += 1
	
	entity.velocity = lerp(entity.velocity, Vector2.ZERO, (entity.accel) * delta)
	
	if frame >= timer:
		return entity.cooldown

func attack():
	var dir = entity.global_position.direction_to(entity.player.global_position).normalized()
	entity.velocity = dir * entity.lunge_strength
