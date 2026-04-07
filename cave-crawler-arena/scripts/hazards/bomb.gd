extends Area2D
class_name Bomb

var vel := 0.0

func _ready():
	$Sprite.frame = 0
	$Collider.disabled = true
	
	await get_tree().create_timer(1.0, false).timeout
	explode()

func explode():
	$Animator.play("explode")

func _physics_process(delta):
	#var dir = Vector2.RIGHT.rotated(rotation)
	#vel = lerpf(vel, 0.0, 3.0 * delta)
	#global_position += dir * vel
	#$Sprite.global_rotation = 0
	pass

func _on_animator_animation_finished(anim_name):
	if anim_name == "explode":
		call_deferred("free")
