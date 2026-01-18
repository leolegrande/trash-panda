extends Area2D

@export var timelinestring : String

func _on_body_entered(body: Node2D):
	if body is MovementController:
		Dialogic.timeline_ended.connect(_on_dialogue_end)
		GameManager.pausable = false
		GameManager.pause_game(true)
		Dialogic.start(timelinestring)

func _on_dialogue_end():
	Dialogic.timeline_ended.disconnect(_on_dialogue_end)
	GameManager.pausable = true
	GameManager.pause_game(false)
	queue_free()