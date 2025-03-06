extends "res://szenen/card/mensch/1/mensch1.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cost = {"Holz":0, "Stein":0, "Metall":4}
	leben = 11
	angriff = 1
	headclass = "Kobold"
	subclass = "Fallenexperte"
	add_to_group("Kobold")
	add_to_group("Fallenexperte")
	update_labels()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
