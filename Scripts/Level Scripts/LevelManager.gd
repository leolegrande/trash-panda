extends Node

var player : MovementController
var spawn_point : Marker2D
var main_cam : CameraScript
@export var init_bounds : Camera2D
@export var level_music : AudioStream

func _ready():
	player = get_tree().get_nodes_in_group("Player")[0] as MovementController
	spawn_point = get_tree().get_nodes_in_group("Spawn")[0] as Marker2D
	main_cam = get_tree().get_nodes_in_group("MainCam")[0] as CameraScript
	reset_level()
	AudioManager.play_audio(level_music)

func _process(delta):
	if (Input.is_action_just_pressed("Reset")):
		reset_level()

func reset_level():
	player.position = spawn_point.position
	main_cam.on_room_entered(init_bounds)

func _on_death_bounds_body_entered(body: Node2D):
	if body == player:
		reset_level()
