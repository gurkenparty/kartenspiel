extends Node3D  # Assuming your card scene root is a Node3D

@export var angriff: int = 10
@export var leben: int = 5

@onready var attack_label = $Stats/angriff  # Adjust the path to your Attack Label3D node
@onready var health_label = $Stats/leben  # Adjust the path to your Health Label3D node

func _ready():
	update_labels()

func update_labels():
	attack_label.text = str(angriff)
	health_label.text = str(leben)
