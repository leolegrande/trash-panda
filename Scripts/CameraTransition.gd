extends Area2D

@export var camBounds : Camera2D

signal player_entered(newBounds : Camera2D)

func _ready():
	var cam := get_viewport().get_camera_2d() as CameraScript
	player_entered.connect(cam.on_room_entered)

func _on_body_entered(body: Node2D):
	if (body is MovementController):
		player_entered.emit(camBounds)