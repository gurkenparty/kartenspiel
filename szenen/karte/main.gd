class_name Karte
extends Node2D

@export var title: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node('Titel').text = self.title
