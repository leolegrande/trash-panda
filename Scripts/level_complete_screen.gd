extends Control

@export var complete_label : Label
@export var complete_text : String
@export var main_menu_path : String

func _ready():
	complete_label.text = complete_text

func _on_button_pressed():
	GameManager.change_scene(main_menu_path)