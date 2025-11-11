extends Panel

func _physics_process(delta):
	if Input.is_action_pressed("stats"):
		visible = true
	else:
		visible = false
	
	$Level.text = str("Level: ", int(Global.level))
	
	$StatBlocks/Speed.text = str("Speed: ", int(Global.stats["speed"][1]))
	$StatBlocks/Health.text = str("Max HP: ", int(Global.stats["maxhp"][1]) * 100)
	$StatBlocks/BulletVel.text = str("Bullet Vel: ", int(Global.stats["bullet_speed"][1]))
	$StatBlocks/Regen.text = str("HP/s: ", str("%0.2f" % (0.1/Global.get_stat("regen_rate"))))
	$StatBlocks/BulletSize.text = str("Bullet Size: ", int(Global.stats["bullet_size"][1]))
	$StatBlocks/PickupRange.text = str("Reach: ", int(Global.stats["pickup_range"][1]))
