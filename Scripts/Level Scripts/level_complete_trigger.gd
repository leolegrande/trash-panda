extends Area2D

@export var complete_screen : Control
@export var level_num : int
@export var timelinestring : String

func _ready():
	GameManager.start_level()
	complete_screen.visible = false

func _on_body_entered(body: Node2D):
	if body is MovementController:
		Dialogic.timeline_ended.connect(_on_dialogue_end)
		GameManager.pausable = false
		GameManager.pause_game(true)
		Dialogic.start(timelinestring)

func _on_dialogue_end():
	Dialogic.timeline_ended.disconnect(_on_dialogue_end)
	GameManager.complete_level(level_num)
	complete_screen.visible = true
