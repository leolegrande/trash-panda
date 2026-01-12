extends State

class_name JumpState

@export var groundState : State
@export var airborneState : State

func enter():
	mc.jump()
	animPlayer.play("Jumping")

func process_physics(delta : float):
	mc.move()
	mc.apply_gravity(delta)
	mc.move_and_slide()
	if (mc.is_on_floor()):
		parent.change_state(groundState)
		return
	if (mc.velocity.y >= 0):
		parent.change_state(airborneState)
		return
	if (Input.is_action_just_released("Jump")):
		mc.end_jump_early()
		parent.change_state(airborneState)
		return

func exit():
	return