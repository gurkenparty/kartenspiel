extends Control

@onready var holz_label = $Holz
@onready var stein_label = $Stein
@onready var metall_label = $Metall
@onready var amethyst_label = $Amethyst
@onready var gold_label = $Gold
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	holz_label.text =  str(GameState.ressources["Holz"])
	stein_label.text =  str(GameState.ressources["Stein"])
	metall_label.text =   str(GameState.ressources["Metall"])
	amethyst_label.text =  str(GameState.ressources["Amethyst"])
	gold_label.text = str(GameState.ressources["Gold"])
