extends State

var ended := false

var interrupt_timing := 0.01

func enter():
	super.enter()
	entity.attack_input_buffer = 0
	
	ended = false
	
	var dir = entity.get_global_mouse_position() - entity.global_position
	dir = dir.normalized()
	dir = dir.angle()
	dir = rad_to_deg(dir)

func physics_update(delta):
	super.physics_update(delta)
	
	entity.velocity = lerp(entity.velocity, Vector2.ZERO, entity.decel * delta)
	
	var remaining_time = entity.animator.current_animation_length - entity.animator.current_animation_position
	if remaining_time < interrupt_timing:
		
		if entity.attack_input_buffer > 0:
			return entity.attack
		
		if entity.roll_input_buffer > 0:
			return entity.roll
	
	if ended:
		return entity.idle

func _on_animator_animation_finished(anim_name):
	if anim_name == "Attack":
		ended = true

func exit():
	super.exit()
	entity.animator.stop()
