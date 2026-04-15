extends VBoxContainer

@export var world : Node2D
var flash_speed = 0.2

func _ready():
	world.player.connect("player_hit", player_hit)

func _physics_process(delta):
	$HPBar.max_value = Global.get_stat("max_health")
	$HPBar.value = Global.health
	$Label.text = str(
		max(0, int(Global.health)), "/",
		Global.get_stat("max_health")
	)

func player_hit():
	if Global.health <= 100:
		flash_health()

func flash_health():
	$Label.add_theme_color_override("font_color", Color.RED)
	await get_tree().create_timer(flash_speed).timeout
	$Label.add_theme_color_override("font_color", Color.WHITE)
	await get_tree().create_timer(flash_speed).timeout
	$Label.add_theme_color_override("font_color", Color.RED)
	await get_tree().create_timer(flash_speed).timeout
	$Label.add_theme_color_override("font_color", Color.WHITE)
	await get_tree().create_timer(flash_speed).timeout
	$Label.add_theme_color_override("font_color", Color.RED)
	await get_tree().create_timer(flash_speed).timeout
	$Label.add_theme_color_override("font_color", Color.WHITE)
