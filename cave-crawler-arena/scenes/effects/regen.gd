extends Sprite2D

var lifetime := 0.5
var fade_rate := 2.0

var target_pos : Vector2

func _ready():
	target_pos = global_position - Vector2(0, 16)

func _physics_process(delta):
	lifetime -= delta
	
	if lifetime <= 0.0:
		call_deferred('free')
	
	global_position.y = lerpf(global_position.y, target_pos.y, 5.0 * delta)
	
	modulate = lerp(modulate, Color.from_hsv(0, 0, 0, 0), 1.0 * delta)
