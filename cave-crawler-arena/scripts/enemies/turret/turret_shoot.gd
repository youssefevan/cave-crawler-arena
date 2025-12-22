extends State


var dir := Vector2.LEFT
var frame := 0
var shots := 0

func enter():
	super.enter()
	shots = 0

func physics_update(delta):
	super.physics_update(delta)
	entity.velocity = lerp(entity.velocity, Vector2.ZERO, entity.accel * delta)
	
	frame += 1
	
	if frame % 60 == 0:
		shoot()
	
	if shots >= 5:
		return entity.chase

func shoot():
	shots += 1
	var b = entity.bullet.instantiate()
	b.global_position = entity.global_position
	b.rotation = (entity.global_position.direction_to(entity.player.global_position + (entity.player.velocity/2))).angle()
	get_tree().get_root().call_deferred("add_child", b)
