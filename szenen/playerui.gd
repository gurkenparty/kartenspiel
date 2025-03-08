extends Control

@export var GameState:Node3D
@onready var holz_label = $Holz
@onready var stein_label = $Stein
@onready var metall_label = $Metall
@onready var amethyst_label = $Amethyst
@onready var gold_label = $Gold
var player_number:int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	player_number = GameState.player_number
	if player_number == GameStateWorld.current_player:
		self.visible = true
	else:
		self.visible = false
	holz_label.text =  str(GameState.ressources["Holz"])
	stein_label.text =  str(GameState.ressources["Stein"])
	metall_label.text =   str(GameState.ressources["Metall"])
	amethyst_label.text =  str(GameState.ressources["Amethyst"])
	gold_label.text = str(GameState.ressources["Gold"])
