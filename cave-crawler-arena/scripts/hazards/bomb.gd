extends Area2D

var timer := 2.5
var dir : Vector2
var vel := 2.0

func _ready():
	timer = Global.get_item("bomb")
	$Sprite.frame = 0
	$Collider.disabled = true
	
	dir = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized()
	
	await get_tree().create_timer(1.0, false).timeout
	explode()

func explode():
	$Animator.play("explode")

func _physics_process(delta):
	vel = lerpf(vel, 0.0, 3.0 * delta)
	global_position += dir * vel

func _on_animator_animation_finished(anim_name):
	if anim_name == "explode":
		call_deferred("free")
