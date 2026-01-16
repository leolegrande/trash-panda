extends Switchable

@export var collider : CollisionShape2D
@export var closed_texture: Texture
@export var open_texture: Texture
@export var sprite : Sprite2D 

func activate():
	active = true
	sprite.texture = open_texture
	collider.set_deferred("disabled", true)

func deactivate():
	active = false
	sprite.texture = closed_texture
	collider.set_deferred("disabled", false)