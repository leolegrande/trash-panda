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
@export var main_menu_music : AudioStream
@export var completed_texture : Texture
@export var locked_texture : Texture
@export var unlocked_texture : Texture

### MAIN MENU BUTTONS ###

func _ready():
	AudioManager.play_audio(main_menu_music)
	set_level_statuses()
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

func set_level_statuses():
	#okay THIS might be the worst code i've ever written
	#level4
	if (GameManager.level3_complete):
		if (GameManager.level4_complete):
			level4_complete_icon.texture = completed_texture
		else:
			level4_complete_icon.texture = unlocked_texture
	else:
			level4_complete_icon.texture = locked_texture
			var button = level4_complete_icon.get_parent() as Button
			button.disabled = true
	#level3
	if (GameManager.level2_complete):
		if (GameManager.level3_complete):
			level3_complete_icon.texture = completed_texture
		else:
			level3_complete_icon.texture = unlocked_texture
	else:
			level3_complete_icon.texture = locked_texture
			var button = level3_complete_icon.get_parent() as Button
			button.disabled = true
	#level2
	if (GameManager.level1_complete):
		if (GameManager.level2_complete):
			level2_complete_icon.texture = completed_texture
		else:
			level2_complete_icon.texture = unlocked_texture
	else:
			level2_complete_icon.texture = locked_texture
			var button = level2_complete_icon.get_parent() as Button
			button.disabled = true
	#level1 & tutorial
	if (GameManager.tutorial_complete):
		tutorial_complete_icon.texture = completed_texture
		if (GameManager.level1_complete):
			level1_complete_icon.texture = completed_texture
		else:
			level1_complete_icon.texture = unlocked_texture
	else:
		tutorial_complete_icon.texture = unlocked_texture
		level1_complete_icon.texture = locked_texture
		var button = level1_complete_icon.get_parent() as Button
		button.disabled = true

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
