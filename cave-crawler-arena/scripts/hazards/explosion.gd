extends Area2D

func _ready():
	$Animator.play("explode")

func delete():
	call_deferred("free")
