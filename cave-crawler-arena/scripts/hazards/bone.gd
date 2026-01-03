extends EnemyBullet

func _ready():
	$Animator.play("move")
	
	super._ready()

func _physics_process(delta):
	super._physics_process(delta)
	$Sprite.global_rotation = 0
