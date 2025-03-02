extends "res://szenen/welt/3d/card/mensch/1/mensch1.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cost = {"Holz":40, "Stein":30, "Metall":20, "Amethyst":10}
	angriff = 4
	leben = 30
	headclass = "Mensch"
	subclass = "Ritter"
	rating = 4
	add_to_group("Mensch")
	add_to_group("Ritter")  
	update_labels()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
