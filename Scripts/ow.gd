extends Label

@export var spawn_position : Vector2

func _ready():
	text = ""

func _on_electric_fence_body_entered(body: Node2D):
	if body is MovementController:
		body.position = spawn_position
		text = "OW!!"
		var timer := Timer.new()
		add_child(timer)
		timer.wait_time = 0.5
		timer.one_shot = true
		timer.timeout.connect(on_timer_timeout)
		timer.start()

func on_timer_timeout():
	text = ""