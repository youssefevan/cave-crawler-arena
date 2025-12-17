extends Bullet

func _ready():
	speed = 90.0
	expiration_timer = 1.0
	$Animator.play("move")
	
	super._ready()

func _physics_process(delta):
	super._physics_process(delta)
	$Sprite.global_rotation = 0

func _on_area_entered(area):
	if area.get_collision_layer_value(5) and area.is_in_group("Player"):
		queue_free()
