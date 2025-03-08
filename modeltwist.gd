extends Node3D

@export var rotation_speed: float = 5.0  # Degrees per second

func _process(delta):
	rotation_degrees.y += rotation_speed * delta
