extends Boss
class_name Miniboss

#@onready var item_scene = preload("res://scenes/pickups/item.tscn")
@onready var bullet_scene = preload("res://scenes/hazards/fireball.tscn")

var dir
var frame := 0
var can_shoot := true
var in_range := false

func _ready():
	super._ready()
	dir = global_position.direction_to(player.global_position)
	$Animator.play("move")

func _physics_process(delta):
	super._physics_process(delta)
	frame += 1
	
	if frame % 5 == 0:
		dir = global_position.direction_to(player.global_position)
	
	if global_position.distance_to(player.global_position) < 110.0:
		velocity = lerp(velocity, dir.normalized() * speed/2.0, accel * delta)
		in_range = true
		shoot()
	else:
		velocity = lerp(velocity, dir.normalized() * speed, accel * delta)
		in_range = false
	
	move_and_slide()

func shoot():
	if can_shoot:
		var b = bullet_scene.instantiate()
		b.rotation = dir.angle()
		b.global_position = global_position
		get_parent().call_deferred("add_child", b)
		
		can_shoot = false
		await get_tree().create_timer(0.75, false).timeout
		can_shoot = true
