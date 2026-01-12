extends CharacterBody2D

class_name Player
# --------- VARIABLES ---------- #

@export_category("Player Properties") # You can tweak these changes according to your likings
@export var move_speed : float = 400
@export var jump_force : float = 600
@export var gravity : float = 30

@export var player_sprite : Sprite2D
@export var anim_player : AnimationPlayer

# --------- BUILT-IN FUNCTIONS ---------- #

func _process(_delta):
	# Calling functions
	movement()
	flip_player()
	
# --------- CUSTOM FUNCTIONS ---------- #

# <-- Player Movement Code -->
func movement():
	# Gravity
	if !is_on_floor():
		handle_airborne()
	else:
		handle_grounded()
	
	# Move Player
	var inputAxis = Input.get_axis("Left", "Right")
	velocity = Vector2(inputAxis * move_speed, velocity.y)
	move_and_slide()

func handle_airborne():
	velocity.y += gravity
	if (velocity.y < 0) && (Input.is_action_just_released("Jump")):
		velocity.y = 0
	return;

# Handles jumping functionality (double jump or single jump, can be toggled from inspector)
func handle_grounded():
	if is_on_floor && Input.is_action_just_pressed("Jump"):
		jump()

# Player jump
func jump():
	jump_tween()
	# AudioManager.jump_sfx.play()
	velocity.y = -jump_force

# Flip player sprite based on X velocity
func flip_player():
	if velocity.x < 0: 
		player_sprite.flip_h = true
	elif velocity.x > 0:
		player_sprite.flip_h = false

func jump_tween():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0.7, 1.4), 0.1)
	tween.tween_property(self, "scale", Vector2.ONE, 0.1)
