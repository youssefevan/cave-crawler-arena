extends Area2D

@export var damage := 40.0

func _ready():
	$Animator.play("spawn")

func despawn():
	call_deferred("free")
