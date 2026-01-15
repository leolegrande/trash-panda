extends Node

class_name FSM

@export var mc : MovementController
@export var animPlayer : AnimatedSprite2D
@export var starting_state : State
var current_state : State

func _ready():
	init_fsm()

func init_fsm():
	for s in get_children():
		if s is State:
			s.parent = self
			s.mc = mc
			s.animPlayer = animPlayer
	if starting_state:
		change_state(starting_state)

func change_state(newState : State):
	if (current_state):
		current_state.exit()
	current_state = newState
	current_state.enter()
	#print("changing state to ", current_state.name)

func _physics_process(delta):
	current_state.process_physics(delta)

func _process(delta):
	current_state.process_frame(delta)

func _unhandled_input(event):
	current_state.process_input(event)
