extends Node
class_name StateManager

@export var starting_state : State
@export var print_states := false

var current_state : State

func init(entity : CharacterBody2D):
	for state in get_children():
		state.entity = entity
	
	current_state = starting_state
	current_state.enter()

func change_state(new_state : State):
	if current_state:
		current_state.exit()
	
	if current_state:
		current_state = null
	
	current_state = new_state
	if print_states:
		print(current_state)
	current_state.enter()

func physics_update(delta):
	var new_state = current_state.physics_update(delta)
	if new_state:
		change_state(new_state)
