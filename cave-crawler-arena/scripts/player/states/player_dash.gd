extends State

func enter():
	super.enter()
	entity.can_dash = false
	entity.animator.play("dash")
	entity.sprite.modulate = Color(0.0, 0.833, 1.0, 1.0)
	entity.hurtbox_collider.disabled = true
	
	entity.after_image.emitting = true
	
	AudioManager.play_sfx(entity.dash_sfx)
	
	var dir = entity.global_position.direction_to(entity.get_global_mouse_position())
	
	var strength = 150.0 + 50.0 * Global.get_item("dash")
	entity.velocity = dir * strength

func physics_update(delta):
	super.physics_update(delta)
	
	entity.handle_input()
	entity.handle_aim()
	
	entity.velocity = lerp(entity.velocity, Vector2.ZERO, 5.0 * delta)
	
	if int(Global.health) <= 0:
		return entity.die
	
	if entity.velocity.length() < 50.0:
		return entity.idle

func exit():
	entity.start_dash_cooldown()
	entity.hurtbox_collider.disabled = false
	entity.sprite.modulate = Color.WHITE
