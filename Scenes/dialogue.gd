extends Node2D

@export var timelinestring : String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.start(timelinestring)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
