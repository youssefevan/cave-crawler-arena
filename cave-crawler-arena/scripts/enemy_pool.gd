extends Node

@export var world : Node2D

func _ready() -> void:
	for i in Global.enemy_pool:
		
		var node = Node.new()
		node.name = i.instantiate().name
		print(node.name)
		
		add_child(node)
		
		for j in range(99):
			var enemy = i.instantiate()
			enemy.world = world
			enemy.player = world.player
			enemy.despawn()
			node.call_deferred("add_child", enemy)
			
			enemy.connect("died", get_parent().enemy_died)
