extends "res://szenen/card/mensch/main.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	cost = {"Holz":10, "Stein": 5}
	angriff = 3 
	leben = 5
	headclass = "Mensch"
	subclass = "Landwirt"
	rating = 3
	add_to_group("Mensch")
	add_to_group("Landwirt")  
	update_labels()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
