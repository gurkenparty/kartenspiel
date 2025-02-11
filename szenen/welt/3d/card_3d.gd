extends Node3D

signal mouse_entered
signal mouse_exited

@onready var area = $Area3D

var original_position
var original_scale

func _ready():
	original_position = global_transform.origin
	original_scale = scale
	area.connect("mouse_entered", _on_mouse_entered)
	area.connect("mouse_exited", _on_mouse_exited)

func _on_mouse_entered():
	mouse_entered.emit()

func _on_mouse_exited():
	mouse_exited.emit()
