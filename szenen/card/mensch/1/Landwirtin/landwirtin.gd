extends "res://szenen/card/mensch/main.gd"


func _ready():
	cost = {"Holz": 2, "Stein":2}
	angriff = 1  # Unique value for Ritter
	leben = 2  # Unique value for Ritter
	headclass = "Mensch"
	subclass = "Landwirt"
	add_to_group("Mensch")
	add_to_group("Landwirt")  # Add to "Ritter" group
	update_labels()
	apply_effect()


func apply_effect():
	pass
