extends Area2D

var expiration_timer := 0.7

func _ready():
	scale = Vector2(Global.get_stat("bullet_size"), Global.get_stat("bullet_size"))
	expiration_timer = 0.7
	await get_tree().create_timer(expiration_timer, false).timeout
	queue_free()

func _physics_process(delta):
	var dir = Vector2.RIGHT.rotated(rotation)
	global_position += dir * Global.get_stat("bullet_speed") * delta

func _on_area_entered(area):
	#if area.get_collision_layer_value(5) and area.is_in_group("Enemy"):
		#queue_free()
	pass
