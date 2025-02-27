extends Control

@onready var holz_label = $HBoxContainer/Holz
@onready var stein_label = $HBoxContainer/Stein
@onready var metall_label = $HBoxContainer/Metall
@onready var amethyst_label = $HBoxContainer/Amethyst
@onready var gold_label = $HBoxContainer/Gold
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	holz_label.text = "Holz: " + str(GameState.ressources["Holz"])
	stein_label.text = "Stein: " + str(GameState.ressources["Stein"])
	metall_label.text = "Metall: " + str(GameState.ressources["Metall"])
	amethyst_label.text = "Amethyst: " + str(GameState.ressources["Amethyst"])
	gold_label.text = "Gold: " + str(GameState.ressources["Gold"])
