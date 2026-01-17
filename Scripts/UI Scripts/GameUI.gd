extends Control

@export var pause_menu : Control
@export var options_menu : Control
@export var game_paused : bool = false
@export var main_menu_scene : String

func _ready():
	pause_menu.visible = false
	options_menu.visible = false
	game_paused = false

func _process(delta):
	if (Input.is_action_just_pressed("Pause") && GameManager.pausable):
		toggle_pause()

func toggle_pause():
	game_paused = !game_paused
	GameManager.game_paused  = game_paused
	pause_menu.visible = game_paused
	options_menu.visible = false

func pause_game():
	GameManager.game_paused = true
	game_paused = true
	pause_menu.visible = true
	options_menu.visible = false

func resume_game():
	GameManager.game_paused = false
	game_paused = false
	pause_menu.visible = false
	options_menu.visible = false

func _on_resume_pressed():
	resume_game()

func _on_options_pressed():
	pause_menu.visible = false
	options_menu.visible = true

func _on_options_back_pressed():
	pause_menu.visible = true
	options_menu.visible = false

func _on_exit_to_main_menu_pressed():
	GameManager.game_paused = false
	GameManager.start_on_level_select = false
	GameManager.change_scene(main_menu_scene)
