extends Explosion

func _on_area_entered(area):
	if area.is_in_group("Enemy"):
		area.get_parent().freeze()
