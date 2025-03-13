extends "res://szenen/aBuilding/gebmain.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cost = {"Holz":0, "Stein":30, "Metall":0, "Amethyst":0}
	leben = 8
	headclass = "Gebaude"
	subclass = "Stein"
	bring_ressources = {"Holz" : 6, "Stein" : 0, "Metall" : 0, "Amethyst" : 0, "Gold" : 0}
	
	add_to_group("Gebaude")
	add_to_group("Stein")
	update_labels()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
