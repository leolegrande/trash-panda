extends Control

@export var main_menu_panel : Control
@export var level_select_panel : Control
@export var options_panel : Control
@export var credits_panel : Control
@export var tutorial_scene : String
@export var level1_scene : String
@export var level2_scene : String
@export var level3_scene : String
@export var level4_scene : String
@export var tutorial_complete_icon : TextureRect
@export var level1_complete_icon : TextureRect
@export var level2_complete_icon : TextureRect
@export var level3_complete_icon : TextureRect
@export var level4_complete_icon : TextureRect

### MAIN MENU BUTTONS ###

func _ready():
	set_complete_status()
	if (!GameManager.start_on_level_select):
		main_menu_panel.visible = true
		level_select_panel.visible = false
		credits_panel.visible = false
		options_panel.visible = false
	else:
		main_menu_panel.visible = false
		level_select_panel.visible = true
		credits_panel.visible = false
		options_panel.visible = false

func set_complete_status():
	tutorial_complete_icon.visible = GameManager.tutorial_complete
	level1_complete_icon.visible = GameManager.level1_complete
	level2_complete_icon.visible = GameManager.level2_complete
	level3_complete_icon.visible = GameManager.level3_complete
	level4_complete_icon.visible = GameManager.level4_complete

func _on_level_select_pressed():
	main_menu_panel.visible = false
	level_select_panel.visible = true
	credits_panel.visible = false
	options_panel.visible = false

func _on_options_pressed():
	main_menu_panel.visible = false
	level_select_panel.visible = false
	credits_panel.visible = false
	options_panel.visible = true

func _on_credits_pressed():
	main_menu_panel.visible = false
	level_select_panel.visible = false
	credits_panel.visible = true
	options_panel.visible = false
	
func _on_exit_game_pressed():
	get_tree().quit()

### LEVEL SELECT BUTTONS ###

func _on_tutorial_pressed():
	GameManager.change_scene(tutorial_scene)

func _on_level_1_pressed():
	GameManager.change_scene(level1_scene)

func _on_level_2_pressed():
	GameManager.change_scene(level2_scene)

func _on_level_3_pressed():
	GameManager.change_scene(level3_scene)

func _on_level_4_pressed():
	GameManager.change_scene(level4_scene)

func _on_level_select_btm_pressed():
	main_menu_panel.visible = true
	level_select_panel.visible = false
	credits_panel.visible = false
	options_panel.visible = false


### CREDITS BUTTONS ###

func _on_credits_btm_pressed():
	main_menu_panel.visible = true
	level_select_panel.visible = false
	credits_panel.visible = false
	options_panel.visible = false

### OPTIONS BUTTON ###

func _on_options_btm_pressed():
	main_menu_panel.visible = true
	level_select_panel.visible = false
	credits_panel.visible = false
	options_panel.visible = false
