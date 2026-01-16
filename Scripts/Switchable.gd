extends Node2D

class_name Switchable

@export var active : bool = true

func activate():
	active = true
	return

func deactivate():
	active = false
	return

func toggle():
	active = !active
	if active: activate()
	else: deactivate()
