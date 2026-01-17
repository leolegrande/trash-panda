extends Node2D

@export var timelinestring : String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.pausable = false
	GameManager.pause_game(true)
	Dialogic.timeline_ended.connect(on_timeline_end)
	Dialogic.start(timelinestring)

func on_timeline_end():
	Dialogic.timeline_ended.disconnect(on_timeline_end)
	GameManager.pause_game(false)
	GameManager.pausable = true
