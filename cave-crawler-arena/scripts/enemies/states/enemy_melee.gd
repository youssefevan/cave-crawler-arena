extends State

var timer = 30
var frame = 0

func enter():
	super.enter()
	entity.animator.play("melee")
	frame = 0

func physics_update(delta):
	super.physics_update(delta)
	frame += 1
	
	entity.velocity = lerp(entity.velocity, Vector2.ZERO, entity.accel * delta)
	
	if frame >= timer:
		return entity.cooldown

func attack():
	var dir = entity.global_position.direction_to(entity.player.global_position).normalized()
	entity.velocity = dir * (entity.lunge_strength/6)
