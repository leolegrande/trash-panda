extends Label

@export var mc : MovementController
@export var fsm : FSM
@export var gm : GumManager

func _ready():
	if (!mc):
		mc = get_tree().get_nodes_in_group("Player")[0]
	fsm = mc.find_child("MovementFSM")
	gm = mc.find_child("GumManager")

func _process(_delta):
	var debug_string = ""
	debug_string += "VELOCITY: %.0v\n" % mc.velocity
	debug_string += "MOVE STATE: %s\n" % fsm.current_state.name
	debug_string += "CHEW VALUE: %.1f\n" % gm.chew_value
	debug_string += "CHEW COOLDOWN: %.1f\n" % gm.chew_cooldown
	text = debug_string
