extends "res://szenen/card/mensch/main.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cost = {"Holz":10, "Stein":0, "Metall":20, "Amethyst":5}
	leben = 25
	angriff = 12
	headclass = "Kobold"
	subclass = "Fallenexperte"
	add_to_group("Kobold")
	add_to_group("Fallenexperte")
	update_labels()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
