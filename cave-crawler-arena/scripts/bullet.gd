extends Area2D

var expiration_timer := 0.4

func _ready():
	expiration_timer = Global.player_stats["atktime"]
	await get_tree().create_timer(expiration_timer, false).timeout
	queue_free()

func _physics_process(delta):
	var dir = Vector2.RIGHT.rotated(rotation)
	global_position += dir * Global.player_stats["bullet_speed"] * delta


func _on_area_entered(area):
	pass
	
	#if area.get_collision_layer_value(5) and area.is_in_group("Enemy"):
		#queue_free()
