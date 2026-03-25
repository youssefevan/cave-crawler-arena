extends Hitbox



func _ready():
	damage = 40.0
	$Animator.play("spawn")

func despawn():
	call_deferred("free")
