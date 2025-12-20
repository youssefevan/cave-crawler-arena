extends Area2D
class_name Explosion

func _ready():
	$Animator.play("explode")

func delete():
	call_deferred("free")
