extends "res://szenen/card/mensch/main.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cost = {"Holz":3, "Stein":1}
	leben = 3
	angriff = 1
	headclass = "Mensch"
	subclass = "Joker"
	add_to_group("Mensch")
	add_to_group("Joker")
	update_labels()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
