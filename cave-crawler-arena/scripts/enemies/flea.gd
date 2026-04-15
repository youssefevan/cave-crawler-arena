extends Enemy

func _ready():
	super._ready()
	jump()

func _physics_process(delta):
	super._physics_process(delta)
	
	velocity = lerp(velocity, Vector2.ZERO, accel * delta)
	
	move_and_slide()
	

func jump():
	var player_dir = global_position.direction_to(player.global_position)
	if abs(player_dir.x) > abs(player_dir.y):
		player_dir = Vector2(sign(player_dir.x), 0.0)
	else:
		player_dir = Vector2(0.0, sign(player_dir.y))
	
	velocity = player_dir * speed
	
	$Animator.play("Jump")
	
	await get_tree().create_timer(1.3, false).timeout
	jump()
