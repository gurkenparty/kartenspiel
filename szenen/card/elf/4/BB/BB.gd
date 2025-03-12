extends "res://szenen/card/mensch/main.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cost = {"Holz":0, "Stein":0, "Metall":9, "Amethyst":2}
	leben = 8
	angriff = 4
	headclass = "Elf"
	subclass = "Edelfamilie"
	add_to_group("Elf")
	add_to_group("Edelfamilie")
	update_labels()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
