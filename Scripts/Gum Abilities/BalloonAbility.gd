extends GumAbility

@export var ground_state : State
@export var BALLOON_FORCE : float
@export var BALLOON_GRAVITY : float
@export var balloon_sprite : AnimatedSprite2D

@export var bubble_sfx: AudioStream
@export var pop_sfx: AudioStream

func _ready():
	balloon_sprite.visible = false

func enter():
	balloon_sprite.visible = true
	balloon_sprite.play("blow_bubble")
	gm.parent.play_audio(bubble_sfx)
	print("used %s!" % ability_name)
	gm.using_ability = true
	balloon_sprite.visible = true
	init_balloon()

func process_physics(delta : float):
	if (Input.is_action_just_released("GumAbility")):
		gm.parent.change_state(ground_state)
		return
	if (gm.chew_value <= 0):
		gm.parent.change_state(ground_state)
		return
	#gm.decrement_chew_value(delta)
	gm.mc.get_movement()
	gm.mc.apply_gravity(delta)
	gm.mc.move()
	if (gm.mc.is_on_floor()):
		gm.parent.change_state(ground_state)
		return


func exit():
	gm.parent.play_audio(pop_sfx)
	balloon_sprite.play("pop_bubble")
	gm.using_ability = false
	gm.mc.gravity = gm.mc.DEFAULT_GRAVITY
	gm.start_ability_cooldown()
	return

func init_balloon():
	gm.mc.set_vertical_force(BALLOON_FORCE)
	gm.mc.gravity = BALLOON_GRAVITY
	gm.chew_value -= 0.5
