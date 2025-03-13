extends "res://szenen/aBuilding/gebmain.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cost = {"Holz":12, "Stein":0, "Metall":0, "Amethyst":0}
	leben = 8
	headclass = "Gebaude"
	subclass = "Holz"
	bring_ressources = {"Holz" : 4, "Stein" : 0, "Metall" : 0, "Amethyst" : 0, "Gold" : 0}
	
	add_to_group("Gebaude")
	add_to_group("Holz")
	update_labels()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
