extends Switchable

@export var water_animation : AnimatedSprite2D
@export var fire_animations : Array[AnimatedSprite2D]
@export var fire_collision_box : CollisionShape2D

func _ready():
	water_animation.play("water")
	for sprite in fire_animations:
		sprite.visible = true
		sprite.play("default")

func deactivate():
	active = false
	water_animation.visible = false
	for sprite in fire_animations:
		sprite.visible = true
	fire_collision_box.set_deferred("disabled", false)

func activate():
	active = true
	water_animation.visible = true
	for sprite in fire_animations:
		sprite.visible = false
	fire_collision_box.set_deferred("disabled", true)
