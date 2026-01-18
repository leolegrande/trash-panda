extends HBoxContainer

var gum_manager : GumManager
@export var slots : Array[TextureRect]
@export var active_color : Color
@export var inactive_color : Color

func _ready():
	var player = get_tree().get_first_node_in_group("Player") as MovementController
	gum_manager = player.gum_manager
	if (!gum_manager):
		queue_free()

func _process(delta):
	#this is actually insanely inefficient but its probably ok right haha
	for i in slots.size():
		var ability = gum_manager.ability_list.get(i)
		if (ability):
			slots[i].texture = ability.icon
			if (ability == gum_manager.current_ability):
				slots[i].modulate = active_color
			else:
				slots[i].modulate = inactive_color
		else:
			slots[i].texture = null
