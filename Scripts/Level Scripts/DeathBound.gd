extends Node

@export var spawn_pos : Marker2D

func _on_body_entered(body: Node2D):
	if (body is MovementController):
		body.global_position = spawn_pos.global_position
		body.play_death_sound()