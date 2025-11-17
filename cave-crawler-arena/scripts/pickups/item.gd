extends Area2D
class_name Item

var direction := Vector2(0, 0)
var decay := 5.0
var vel := 1.0

var player : Player = null
var despawn_timer := 120.0

@export var item_name = "item1"

func _ready():
	direction.x = randf_range(-1, 1)
	direction.y = randf_range(-1, 1)
	
	await get_tree().create_timer(despawn_timer, false).timeout
	despawn()
	

func despawn():
	if player != null:
		await get_tree().create_timer(5.0, false).timeout
		despawn()
	
	queue_free()

func _physics_process(delta):
	vel = lerpf(vel, 0.0, decay * delta)
	global_position += direction * vel
	
	if player:
		if Input.is_action_just_pressed("pickup"):
			if Global.equipped_item != null:
				var old_item = Global.item_pool[Global.equipped_item].instantiate()
				old_item.despawn_timer = 20.0
				old_item.global_position = global_position
				get_parent().add_child(old_item)
			
			Global.equipped_item = item_name
			queue_free()

func _on_body_entered(body):
	if body is Player:
		player = body
		$Label.visible = true

func _on_body_exited(body):
	if body is Player:
		player = null
		$Label.visible = false
