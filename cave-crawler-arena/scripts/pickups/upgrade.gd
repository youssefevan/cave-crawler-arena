extends Pickup
class_name Upgrade

signal upgrade_collected

func _ready():
	speed = 60.0
	super._ready()

func despawn():
	upgrade_collected.emit()
	queue_free()
