extends Bullet

func _ready():
	speed = 70.0
	expiration_timer = 2.0
	$Animator.play("move")

func _physics_process(delta):
	super._physics_process(delta)
	$Sprite.global_rotation = 0

func _on_area_entered(area):
	if area.get_collision_layer_value(5) and area.is_in_group("Player"):
		queue_free()
