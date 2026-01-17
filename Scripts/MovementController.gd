extends CharacterBody2D

class_name MovementController

@export var move_speed : float = 400
@export var jump_force : float = 600
var gravity : float = 30
@export var DEFAULT_GRAVITY : float = 30

@export var player_sprite : AnimatedSprite2D
@export var anim_player : AnimationPlayer


func _ready():
	gravity = DEFAULT_GRAVITY

func get_movement():
	var inputAxis = Input.get_axis("Left", "Right")
	velocity = Vector2(inputAxis * move_speed, velocity.y)
	flip_player()

func set_vertical_force(force : float):
	velocity.y = -force

func jump():
	velocity.y = -jump_force

func flip_player():
	if velocity.x < 0: 
		player_sprite.flip_h = true
	elif velocity.x > 0:
		player_sprite.flip_h = false

func end_jump_early():
	velocity.y = 0

func apply_gravity(_delta : float):
	velocity += -gravity * up_direction

func move():
	move_and_slide()
