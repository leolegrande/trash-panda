extends State

@export var groundState : State

func enter():
	animPlayer.play("Falling")

func process_physics(delta : float):
	mc.get_movement()
	mc.apply_gravity(delta)
	mc.move()
	if (mc.is_on_floor()):
		parent.change_state(groundState)
		return