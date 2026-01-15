extends Node

var pausable : bool = true

var game_paused : bool = false

var tutorial_complete : bool = false
var level1_complete : bool = false
var level2_complete : bool = false
var level3_complete : bool = false
var level4_complete : bool = false

var start_on_level_select : bool = false

func change_scene(new_scene : String):
	call_deferred("deferred_change_scene", new_scene)

func deferred_change_scene(new_scene : String):
	get_tree().change_scene_to_file(new_scene)

func start_level():
	pausable = true
	game_paused = false

func complete_level(level_num : int):
	pausable = false
	start_on_level_select = true
	game_paused = true
	match level_num:
		0: tutorial_complete = true
		1: level1_complete = true
		2: level2_complete = true
		3: level3_complete = true
		4: level4_complete = true
		_: print("level not found")