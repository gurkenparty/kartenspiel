extends "res://karten/mensch/1/mensch1.gd"  # Extend the base troop class


func _ready():
	angriff = 1  # Unique value for Ritter
	leben = 2  # Unique value for Ritter
	headclass = "Mensch"
	subclass = "Landwirt"
	add_to_group("Mensch")
	add_to_group("Landwirt")  # Add to "Ritter" group
	update_labels()
	apply_effect()
	cardmenu_path = "res://szenen/welt/3d/card/" + str(headclass.to_lower()) + "/" + str(rating) + "/" + str(self.name).to_lower() + "/cardmenu.tscn"
	print("path for" + str(self.name) + "is: " + str(cardmenu_path))
	cardmenu = load(cardmenu_path)

func apply_effect():
	pass
