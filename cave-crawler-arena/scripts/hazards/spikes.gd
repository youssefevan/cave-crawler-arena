extends Hitbox



func _ready():
	damage = 120.0
	$Animator.play("spawn")

func despawn():
	call_deferred("free")
