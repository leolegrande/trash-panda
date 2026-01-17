extends Switchable

@export var path_follow : PathFollow2D
@export var platform_speed : float = 200

func _physics_process(delta):
	if (active && !GameManager.game_paused):
		path_follow.progress += delta * platform_speed