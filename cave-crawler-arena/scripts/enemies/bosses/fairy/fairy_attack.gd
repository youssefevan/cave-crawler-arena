extends State

var attack_rate := 0.5
var attack_time := 0.5

var state_time := 3.0

func enter():
	super.enter()
	attack_time = attack_rate
	state_time = 3.0
	entity.animator.play("Attack")

func physics_update(delta):
	super.physics_update(delta)
	entity.velocity = lerp(entity.velocity, Vector2.ZERO, entity.accel * delta)
	
	state_time -= delta
	attack_time -= delta
	
	if state_time < 0.0:
		return entity.recover 
	
	if attack_time < 0.0:
		entity.spawn_ring()
		attack_time = attack_rate
