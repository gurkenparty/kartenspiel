extends "res://szenen/card/mensch/main.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cost = {"Holz":0, "Stein":6, "Metall":1, "Amethyst":0}
	leben = 5
	angriff = 2
	headclass = "Ork"
	subclass = "Grobian"
	add_to_group("Ork")
	add_to_group("Grobian")
	update_labels()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
