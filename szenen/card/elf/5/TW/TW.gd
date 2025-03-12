extends "res://szenen/card/mensch/main.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cost = {"Holz":0, "Stein":0, "Metall":12, "Amethyst":3}
	leben = 15
	angriff = 0
	headclass = "Elf"
	subclass = "Edelfamilie"
	add_to_group("Elf")
	add_to_group("Edelfamilie")
	update_labels()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
