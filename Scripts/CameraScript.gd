extends Camera2D

class_name CameraScript
#whenever player enters a roomtrigger, sets camera position

func _ready():
	make_current()

func on_room_entered(newCamBounds : Camera2D):
	zoom = newCamBounds.zoom
	limit_right = newCamBounds.limit_right
	limit_left = newCamBounds.limit_left
	limit_top = newCamBounds.limit_top
	limit_bottom = newCamBounds.limit_bottom
	return
