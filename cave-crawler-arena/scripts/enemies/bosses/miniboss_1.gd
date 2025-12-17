extends Boss
class_name Miniboss

@onready var item_scene = preload("res://scenes/pickups/item.tscn")
@onready var bullet_scene = preload("res://scenes/hazards/bone.tscn")

var dir
var frame := 0

func _ready():
	super._ready()
	dir = global_position.direction_to(player.global_position).normalized()

func _physics_process(delta):
	super._physics_process(delta)
	frame += 1
	
	if frame % 5 == 0:
		dir = global_position.direction_to(player.global_position).normalized()
	
	if frame % 30 == 0 and global_position.distance_to(player.global_position) < 80:
		var b = bullet_scene.instantiate()
		b.rotation = dir.angle()
		b.global_position = global_position
		get_parent().call_deferred("add_child", b)
	
	velocity = lerp(velocity, dir * speed, accel * delta)
	
	move_and_slide()

func die():
	var item = item_scene.instantiate()
	item.global_position = global_position
	get_parent().get_parent().call_deferred("add_child", item)
	
	super.die()
