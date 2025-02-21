extends "res://szenen/welt/3d/card/mensch/1/mensch1.gd"


func _ready():
	angriff = 1  
	leben = 2  
	add_to_group("Mensch")
	add_to_group("Ritter")  
	update_labels()
