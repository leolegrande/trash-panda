extends Area2D

class_name WhipSwitch

@export var active : bool = false
@export var switchable : Switchable
@export var off_sprite : Texture2D
@export var on_sprite : Texture2D
@export var sprite : Sprite2D

func _ready():
	sprite.texture = on_sprite if active else off_sprite
	if active: switchable.activate()
	else: switchable.deactivate()

func toggle():
	active = !active
	sprite.texture = on_sprite if active else off_sprite
	switchable.toggle()
