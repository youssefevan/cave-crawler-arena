extends Boss

var dir = Vector2.ZERO
var frame := 0
var in_range := false
var can_shoot := true

@onready var bullet_scene = preload("res://scenes/hazards/star.tscn")

func _ready():
	super._ready()
	dir = global_position.direction_to(player.global_position)

func _physics_process(delta):
	super._physics_process(delta)
	
	frame += 1
	
	if frame % 5 == 0:
		dir = global_position.direction_to(player.global_position)
	
	if global_position.distance_to(player.global_position) > 60.0:
		velocity = lerp(velocity, dir.normalized() * speed, accel * delta)
	else:
		velocity = lerp(velocity, dir.normalized() * speed/4.0, accel * delta)
		shoot()
	
	move_and_slide()

func shoot():
	if can_shoot:
		var spread_angle_degrees = 360.0
		var num_bullets = 8
		var start_angle = rotation_degrees - spread_angle_degrees / 2
		var angle_step = spread_angle_degrees / (num_bullets - 1)
			
		for i in range(num_bullets):
			var b = bullet_scene.instantiate()
			b.rotation_degrees = start_angle + angle_step * i
			b.global_position = global_position
			world.bullets.add_child(b)
		
		can_shoot = false
		await get_tree().create_timer(0.5, false).timeout
		can_shoot = true
