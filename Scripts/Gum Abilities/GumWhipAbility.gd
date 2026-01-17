extends GumAbility

#this might be some of the worst code i've ever written
@export var ground_state : State
@export var whip_line : Line2D
@export var WHIP_SPEED : float = 0.5
@export var whip_hitbox : Area2D
@export var whip_collider : CollisionShape2D
@export var BASE_WHIP_DISTANCE : float = 100
var whip_active : bool = false
var power : float
var endpoint_vector : Vector2
var whip_timer : float
@export var whip_sfx : AudioStream

func _ready():
	activate_hitbox(false)
	return

func enter():
	if (whip_active):
		print("whip is already active!")
	elif (gm.chew_value < 1):
		print("not enough chew!")
	else:
		init_whip()
	gm.parent.change_state(ground_state)

func init_whip():
	gm.parent.play_audio(whip_sfx)
	gm.using_ability = true
	activate_hitbox(true)
	activate_line()
	power = get_gum_power()
	endpoint_vector = get_end_point(power)
	whip_timer = 0
	whip_hitbox.position = Vector2.ZERO
	whip_active = true #process_physics will run while whip_active is true

func _physics_process(delta):
	if (whip_active):
		var weight = (whip_timer / WHIP_SPEED)
		var whip_point_pos = Vector2.ZERO.lerp(endpoint_vector, weight)
		whip_hitbox.position = whip_point_pos
		whip_line.set_point_position(1, whip_point_pos)
		if (whip_timer >= WHIP_SPEED):
			end_whip()
		whip_timer += delta

func end_whip():
	whip_active = false
	whip_hitbox.position = Vector2.ZERO
	whip_timer = WHIP_SPEED
	endpoint_vector = Vector2.ZERO
	power = 0
	reset_line()
	activate_hitbox(false)
	gm.using_ability = false


func exit():
	return

func get_end_point(gum_power : float) -> Vector2:
	var normalized_end_point : Vector2 = (get_global_mouse_position() - whip_line.global_position).normalized()
	var end_point = normalized_end_point * gum_power * BASE_WHIP_DISTANCE
	return end_point

func activate_hitbox(active : bool):
	whip_collider.set_deferred("disabled", !active)

func reset_line():
	whip_line.clear_points()

func activate_line():
	if (whip_line.get_point_count() >= 1): reset_line()
	whip_line.add_point(Vector2.ZERO)
	whip_line.add_point(Vector2.ZERO)

func get_gum_power() -> float:
	if gm.chew_value >= 3:
		gm.chew_value -= 3
		return 3
	elif gm.chew_value >= 2:
		gm.chew_value -= 2
		return 2
	gm.chew_value -= 1
	return 1

func _on_whip_hitbox_area_entered(area):
	print("whip hit something!")
	if area is WhipSwitch:
		area.toggle()
	end_whip()

func _on_whip_endpoint_body_entered(body: Node2D):
	print("whip hit something!")
	if body is WhipSwitch:
		body.toggle()
	end_whip()
