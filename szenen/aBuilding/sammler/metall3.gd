extends "res://szenen/aBuilding/gebmain.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cost = {"Holz":0, "Stein":0, "Metall":12, "Amethyst":0}
	leben = 8
	headclass = "Gebaude"
	subclass = "Metall"
	bring_ressources = {"Holz" : 0, "Stein" : 0, "Metall" : 4, "Amethyst" : 0, "Gold" : 0}
	
	add_to_group("Gebaude")
	add_to_group("Metall")
	update_labels()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
