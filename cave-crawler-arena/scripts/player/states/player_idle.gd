extends State

func enter():
	super.enter()
	entity.animator.play("idle")

func physics_update(delta):
	super.physics_update(delta)
	
	entity.handle_input()
	entity.handle_aim()
	
	entity.velocity = lerp(entity.velocity, Vector2.ZERO, entity.decel * delta)
	
	if entity.input != Vector2.ZERO:
		return entity.move
	
	if Input.is_action_just_pressed("dash"):
		if Global.get_item("dash") > 0 and entity.can_dash:
			return entity.dash
	
	if int(Global.health) <= 0:
		return entity.die
