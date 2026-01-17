extends State

class_name GumManager

@export var MAX_CHEW_VALUE : float = 5.0
@export var CHEW_COOLDOWN_DURATION : float = 0.5
@export var ABILITY_COOLDOWN_DURATION : float = 0.5
@export var CHEW_DECAY_SPEED : float = 1.0
var chew_value : float
@export var ability_list : Array[GumAbility]
var current_ability : GumAbility
var current_ability_index : int = 0
var chew_cooldown : float
var ability_cooldown : float
var using_ability : bool
@export var infinite_chew : bool = false
@export var has_ability : bool = true

func _ready():
	if (!has_ability):
		return
	chew_value = 0
	ability_list = []
	using_ability = false
	for c in get_children():
		if (c is GumAbility):
			c.gm = self
			ability_list.append(c)
	set_ability(0)

func _process(delta):
	if (GameManager.game_paused): return
	if (!has_ability):
		return
	handle_cooldown(delta)
	if (!using_ability):
		handle_input()
	if (infinite_chew):
		chew_value = MAX_CHEW_VALUE
	decrement_chew_value(delta)

func start_ability_cooldown():
	ability_cooldown = ABILITY_COOLDOWN_DURATION

func decrement_chew_value(delta : float):
	chew_value = clampf(chew_value-(delta*CHEW_DECAY_SPEED), 0, 5) 

func handle_cooldown(delta):
	if chew_cooldown > 0:
		chew_cooldown = clampf(chew_cooldown-delta, 0, CHEW_COOLDOWN_DURATION)
	if ability_cooldown > 0:
		ability_cooldown = clampf(ability_cooldown-delta, 0, ABILITY_COOLDOWN_DURATION)

#func _unhandled_input(event):
	#if (!using_ability):
		#if event.is_action_pressed("Chew"):
			#chew_gum()
		#if event.is_action_pressed("GumAbility"):
			#use_ability()
		#if event.is_action_pressed("Next Ability"):
			#change_ability(1)
		#if event.is_action_pressed("Prev Ability"):
			#change_ability(-1)

func handle_input():
	if (GameManager.game_paused): return
	if Input.is_action_just_pressed("Chew"):
		chew_gum()
	if Input.is_action_just_pressed("GumAbility"):
		use_ability()
	if Input.is_action_just_pressed("Next Ability"):
		change_ability(1)
	if Input.is_action_just_pressed("Prev Ability"):
		change_ability(-1)

func change_ability(dir : int):
	if (ability_list.size() <= 1): return
	set_ability((current_ability_index+dir)%ability_list.size())

func set_ability(index : int):
	var new_ability = ability_list[index]
	if (new_ability):
		current_ability = new_ability
		current_ability_index = ability_list.find(current_ability)

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
	if (ability_cooldown > 0):
		print("ability still on cooldown!")
		return
	#if (chew_value < 1):
		#print("not enough chew to use ability!")
		#return
	parent.change_state(current_ability)
