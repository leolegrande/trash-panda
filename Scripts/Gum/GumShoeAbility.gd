extends GumAbility

class_name GumShoeAbility
@export var airborneState : State
@export var GUMSHOE_MOVE_SPEED : float = 200
@export var ceiling_detection : RayCast2D
@export var right_wall_detection : RayCast2D
@export var left_wall_detection : RayCast2D
var lmb_released : bool

var wall_normal : Vector2
var snap_position : Vector2

func enter():
	if (!mc): mc = gm.mc
	if (!detect_collisions()):
		print("No collisions detected")
		gm.parent.change_state(airborneState)
		return
	stick_to_wall()

#func process_input(event : InputEvent):
	#if (event.is_action_pressed("GumAbility")):
		#print("exiting gumshoe: pressed lmb")
		#gm.parent.change_state(airborneState)
		#return

func process_physics(delta : float):
	gm.decrement_chew_value(delta)
	mc.velocity = get_wall_movement()
	mc.move_and_slide()
	flip_player()
	handle_animations()
	if (Input.is_action_just_pressed("Jump")):
		if (!on_ceiling()):
			wall_jump()
		print("exiting gumshoe: pressed jump")
		gm.parent.change_state(airborneState)
		return
	if (Input.is_action_just_pressed("GumAbility") && lmb_released):
		print("exiting gumshoe: pressed lmb")
		gm.parent.change_state(airborneState)
		return
	if (gm.chew_value <= 0):
		print("exiting gumshoe: ran outta chew")
		gm.parent.change_state(airborneState)
		return
	if (!mc.is_on_floor()):
		print("exiting gumshoe: not on floor")
		gm.parent.change_state(airborneState)
		return
	#literally the shittiest workaround but whatever
	if (Input.is_action_just_released("GumAbility")):
		lmb_released = true

func exit():
	if (gm.using_ability):
		mc.position += wall_normal*30
	gm.using_ability = false
	lmb_released = true
	mc.up_direction = Vector2.UP
	mc.rotation_degrees = 0
	gm.start_ability_cooldown()
	return

func detect_collisions() -> bool:
	if (ceiling_detection.is_colliding()):
		snap_position = ceiling_detection.get_collision_point()
		wall_normal = ceiling_detection.get_collision_normal()
		return true
	elif (right_wall_detection.is_colliding()):
		snap_position = right_wall_detection.get_collision_point()
		wall_normal = right_wall_detection.get_collision_normal()
		return true
	elif (left_wall_detection.is_colliding()):
		snap_position = left_wall_detection.get_collision_point()
		wall_normal = left_wall_detection.get_collision_normal()
		return true
	else:
		return false

func stick_to_wall():
	gm.using_ability = true
	lmb_released = false
	rotate_player()
	mc.global_position = snap_position
	mc.up_direction = wall_normal

func get_wall_movement() -> Vector2:
	if (!on_ceiling()):
		var inputAxis = Input.get_axis("Down", "Up")
		return Vector2(0, -inputAxis*GUMSHOE_MOVE_SPEED)
	var inputAxis = Input.get_axis("Left", "Right")
	return Vector2(inputAxis*GUMSHOE_MOVE_SPEED, 0)

func rotate_player():
	if (on_ceiling()):
		mc.rotation_degrees = 180
	else:
		mc.rotation_degrees = 90*wall_normal.x

func wall_jump():
	mc.velocity.y = -mc.jump_force
	mc.velocity.x = 400 * wall_normal.x

func handle_animations():
	if (on_ceiling()):
		if (mc.velocity.x != 0 && gm.animPlayer.current_animation != "Run"):
			gm.animPlayer.play("Run")
		elif (mc.velocity.x == 0 && gm.animPlayer.current_animation != "Idle"):
			gm.animPlayer.play("Idle")
	else:
		if (mc.velocity.y != 0 && gm.animPlayer.current_animation != "Run"):
			gm.animPlayer.play("Run")
		elif (mc.velocity.y == 0 && gm.animPlayer.current_animation != "Idle"):
			gm.animPlayer.play("Idle")

func on_ceiling() -> bool:
	return (wall_normal == Vector2.DOWN)

func flip_player():
	if (on_ceiling()):
		if mc.velocity.x < 0: 
			mc.player_sprite.flip_h = false
		elif mc.velocity.x > 0:
			mc.player_sprite.flip_h = true
	else:
		if (mc.velocity.y < 0):
			mc.player_sprite.flip_h = (wall_normal==Vector2.RIGHT)
		elif (mc.velocity.y > 0):
			mc.player_sprite.flip_h = !(wall_normal==Vector2.RIGHT)
