extends State

class_name GumManager

@export var MAX_CHEW_VALUE : float = 5.0
@export var CHEW_COOLDOWN_DURATION : float = 1.0
var chew_value : float
@export var ability_list : Array[GumAbility]
var current_ability : GumAbility
var chew_cooldown : float
var using_ability : bool

func _ready():
	chew_value = 0
	ability_list = []
	using_ability = false
	for c in get_children():
		if (c is GumAbility):
			c.gm = self
			ability_list.append(c)
	if (ability_list[0]):
		current_ability = ability_list[0]

func _process(delta):
	handle_cooldown(delta)
	handle_input()

func decrement_chew_value(delta : float):
	chew_value -= delta

func handle_cooldown(delta):
	if chew_cooldown > 0:
		chew_cooldown = clampf(chew_cooldown-delta, 0, CHEW_COOLDOWN_DURATION)

func handle_input():
	if Input.is_action_just_pressed("Chew"):
		chew_gum()
	if Input.is_action_just_pressed("GumAbility"):
		use_ability()

func chew_gum():
	if (chew_cooldown > 0):
		print("can't chew yet!")
		return
	if (chew_value == MAX_CHEW_VALUE):
		print("chew is maxed out!")
		return
	if (using_ability):
		print("can't chew while using an ability!")
		return
	if (chew_value < MAX_CHEW_VALUE):
		chew_value = clampf(chew_value+1, 0, 5)
		chew_cooldown = CHEW_COOLDOWN_DURATION

func use_ability():
	if (chew_value >= 1):
		parent.change_state(current_ability)