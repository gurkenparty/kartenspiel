extends "res://szenen/card/mensch/main.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cost = {"Holz":5, "Stein":3, "Metall":2}
	angriff = 6
	leben = 6
	headclass = "Mensch"
	subclass = "Ritter"
	rating = 4
	add_to_group("Mensch")
	add_to_group("Ritter")  
	update_labels()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
