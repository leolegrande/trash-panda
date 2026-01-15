extends Area2D

class_name Switchable

@export var active : bool = true
@export var collider : CollisionShape2D
@export var off_animation : String
@export var on_animation : String
@export var anim_player : AnimationPlayer

func activate():
	active = true
	anim_player.play(on_animation)
	collider.set_deferred("disabled", false)

func deactivate():
	active = false
	anim_player.play(off_animation)
	collider.set_deferred("disabled", true)

func toggle():
	active = !active
	if active: activate()
	else: deactivate()

func _on_body_entered(body: Node2D):
	if body is MovementController:
		print("player died!!!")
