extends Node

class_name FSM


@export var mc : MovementController
@export var animPlayer : AnimatedSprite2D
@export var starting_state : State
var current_state : State
@export var player_audio : AudioStreamPlayer

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
	if (GameManager.game_paused): return
	current_state.process_physics(delta)

func _process(delta):
	if (GameManager.game_paused): return
	current_state.process_frame(delta)

func _unhandled_input(event):
	if (GameManager.game_paused): return
	current_state.process_input(event)

func play_audio(audio : AudioStream):
	player_audio.stream = audio
	player_audio.play()
