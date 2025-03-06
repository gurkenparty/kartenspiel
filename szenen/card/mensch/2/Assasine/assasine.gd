extends "res://szenen/card/mensch/1/mensch1.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	cost = {"Holz":4, "Stein":1}
	angriff = 2
	leben = 2
	headclass = "Mensch"
	subclass = "Joker"
	rating = 2
	add_to_group("Mensch")
	add_to_group("Joker")  
	update_labels()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
