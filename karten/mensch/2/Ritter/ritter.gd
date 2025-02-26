extends "res://karten/mensch/1/mensch1.gd"


func _ready():
	angriff = 1  
	leben = 2
	headclass = "Mensch"
	subclass = "Ritter"
	rating = 2
	add_to_group("Mensch")
	add_to_group("Ritter")  
	update_labels()
	cardmenu_path = "res://szenen/welt/3d/card/" + str(headclass.to_lower()) + "/" + str(rating) + "/" + str(self.name).to_lower() + "/cardmenu.tscn"
	print("path for" + str(self.name) + "is: " + str(cardmenu_path))
	cardmenu = load(cardmenu_path)
