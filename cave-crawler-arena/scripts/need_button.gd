extends CheckBox

@export var cost := 10
@export var title := "Rent"

func _ready():
	connect("visibility_changed", on_visibility_changed)
	connect("pressed", on_pressed)
	text = str(title, ": ", cost)

func _physics_process(delta):
	if Global.player_stats["coin"] < cost:
		button_pressed = false
		disabled = true
	else:
		disabled = false

func on_visibility_changed():
	if visible:
		button_pressed = false

func on_pressed():
	if button_pressed:
		Global.player_stats["coin"] -= cost
	if !button_pressed:
		Global.player_stats["coin"] += cost
