extends Boss
class_name Miniboss

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
	
	velocity = lerp(velocity, dir * speed, accel * delta)
	
	move_and_slide()

func die():
	var available_items = Global.item_pool.duplicate()
	if Global.equipped_item != null:
		available_items.erase(Global.equipped_item)
	
	var key = available_items.keys().pick_random()
	var item = Global.item_pool[key].instantiate()
	item.global_position = global_position
	get_parent().get_parent().add_child(item)
	
	super.die()
