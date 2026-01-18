extends TextureProgressBar

var gum_manager : GumManager

func _ready():
	var player = get_tree().get_first_node_in_group("Player") as MovementController
	gum_manager = player.gum_manager
	if (!gum_manager):
		queue_free()

func _process(delta):
	if (gum_manager):
		value = gum_manager.chew_value