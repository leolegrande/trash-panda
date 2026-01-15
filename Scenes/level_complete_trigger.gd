extends Area2D

@export var complete_screen : Control
@export var level_num : int

func _ready():
	GameManager.start_level()
	complete_screen.visible = false

func _on_body_entered(body: Node2D):
	if body is MovementController:
		GameManager.complete_level(level_num)
		complete_screen.visible = true
