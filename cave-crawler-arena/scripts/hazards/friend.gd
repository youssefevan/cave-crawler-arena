extends Hitbox
class_name Friend

func _physics_process(delta):
	$Sprite.global_rotation = 0.0
	
	if Global.get_item("skull_friend") == 0.0:
		visible = false
		$CollisionShape2D.disabled = true
	else:
		visible = true
		$CollisionShape2D.disabled = false
