# https://www.youtube.com/watch?v=iny4KAtVMCg

extends Sprite2D

var onscreen_offset = Vector2(0.0, -12.0)
var screen_margin := 16.0

var camera : Camera2D

func _ready():
	camera = get_viewport().get_camera_2d()

func _physics_process(delta):
	if not camera:
		camera = get_viewport().get_camera_2d()
		return
	
	var target_pos = get_parent().global_position
	var viewport_dim = get_viewport().get_visible_rect().size
	var screen_coords = (target_pos - camera.global_position) * camera.zoom + viewport_dim * 0.5
	var screen_rect = Rect2(Vector2.ZERO, viewport_dim).grow(-screen_margin)
	
	var target_display_pos : Vector2
	var target_display_rot : float
	
	if screen_rect.has_point(screen_coords):
		target_display_pos = target_pos + onscreen_offset
		target_display_rot = 0.0
	else:
		var x = clamp(screen_coords.x, screen_margin, viewport_dim.x - screen_margin)
		var y = clamp(screen_coords.y, screen_margin, viewport_dim.y - screen_margin)
		var clamped_screen_coords = Vector2(x, y)
		
		target_display_pos = camera.global_position + (clamped_screen_coords - viewport_dim * 0.5) / camera.zoom
		
		var dir = target_pos - target_display_pos
		target_display_rot = dir.angle() - PI * 0.5
	
	global_position = lerp(global_position, target_display_pos, delta * 8.0)
	rotation = lerp(rotation, target_display_rot, delta * 8.0)
	
	#global_position = target_display_pos
	#rotation = target_display_rot
