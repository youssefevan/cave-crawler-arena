extends Hitbox
class_name Friend

func _physics_process(delta):
	$Sprite.global_rotation = 0.0

func enable_friend():
	visible = true
	$CollisionShape2D.disabled = false

func disable_friend():
	visible = false
	$CollisionShape2D.disabled = true

func _on_area_entered(area):
	if area is EnemyBullet:
		area.dir = -area.dir
		
		# allow damage to enemies
		area.target_group = "Enemy"
		area.remove_from_group("Enemy")
		area.add_to_group("Player")
		
		area.sprite.self_modulate = Color(18.892, 0.0, 0.0)
