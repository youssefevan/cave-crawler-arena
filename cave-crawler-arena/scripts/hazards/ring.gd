extends EnemyBullet

var current_speed = 0.0
var target

func _physics_process(delta):
	var dir = global_position.direction_to(target.global_position)
	
	current_speed = lerpf(current_speed, speed, 0.2 * delta)
	
	global_position += dir * current_speed * delta
