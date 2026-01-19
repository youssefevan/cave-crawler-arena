extends Area2D
class_name Bullet

@onready var explosion = preload("res://scenes/hazards/explosion.tscn")
#@onready var fire_explosion = preload("res://scenes/hazards/fire_explosion.tscn")
#@onready var freeze_explosion = preload("res://scenes/hazards/freeze_explosion.tscn")

@onready var hit_effect = preload("res://scenes/effects/bullet_hit.tscn")

var speed = 220.0
var expiration_timer := 0.6

func _ready():
	expiration_timer = Global.get_stat("bullet_life")
	scale.x = Global.get_stat("bullet_size")
	scale.y = Global.get_stat("bullet_size")
	
	await get_tree().create_timer(expiration_timer, false).timeout
	
	queue_free()

func _physics_process(delta):
	var dir = Vector2.RIGHT.rotated(rotation)
	global_position += dir * speed * delta

func _on_area_entered(area):
	if area.get_collision_layer_value(5) and area.is_in_group("Enemy"):
		#if Global.equipped_item == "bomb":
			#var e = explosion.instantiate()
			#e.global_position = global_position
			#get_parent().call_deferred("add_child", e)
		#elif Global.equipped_item == "fire":
			#var e = fire_explosion.instantiate()
			#e.global_position = global_position
			#get_parent().call_deferred("add_child", e)
		#elif Global.equipped_item == "freeze":
			#var e = freeze_explosion.instantiate()
			#e.global_position = global_position
			#get_parent().call_deferred("add_child", e)
		
		var h = hit_effect.instantiate()
		h.global_position = global_position
		get_parent().call_deferred("add_child", h)
		
		#if Global.equipped_item == "penetration":
			#return
		
		#queue_free()
