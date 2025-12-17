extends Area2D

func _ready():
	$Animator.play("spawn")

func despawn():
	call_deferred("free")
