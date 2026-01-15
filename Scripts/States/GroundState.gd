extends State

class_name GroundState

@export var jumpState : State
@export var airborneState : State

func enter():
	return

func process_physics(delta : float):
	mc.get_movement()
	mc.move()
	if (mc.velocity.x != 0 && animPlayer.animation != "run"):
		animPlayer.play("run")
	elif (mc.velocity.x == 0 && animPlayer.animation != "idle"):
		animPlayer.play("idle")
	if (Input.is_action_just_pressed("Jump")):
		parent.change_state(jumpState)
		return
	if (!mc.is_on_floor()):
		parent.change_state(airborneState)
		return

func exit():
	return
