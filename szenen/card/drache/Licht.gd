extends "res://szenen/card/mensch/main.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cost = {"Holz":0, "Stein":0, "Metall":0, "Amethyst":2}
	leben = 2
	angriff = 2
	headclass = "Drache"
	subclass = "--"
	add_to_group("Drache")
	add_to_group("--")
	update_labels()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
