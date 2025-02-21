extends "res://szenen/welt/3d/card/mensch/1/mensch1.gd"  # Extend the base troop class


func _ready():
	angriff = 1  # Unique value for Ritter
	leben = 2  # Unique value for Ritter
	add_to_group("Mensch")
	add_to_group("Landwirt")  # Add to "Ritter" group
	update_labels()
	apply_effect()

func apply_effect():
	pass
