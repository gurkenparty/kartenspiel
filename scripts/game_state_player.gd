extends Node
@onready var option_btn: Button = get_tree().get_root().find_child("option_btn", true, false)
@onready var weiter_btn: Button = get_tree().get_root().find_child("weiter", true, false)
@export var player: int = 1

var placed_cards = {}  # Stores placed card positions
var field_start_x = -9.0  # Left-most position on the field
var field_spacing = 3  # Distance between cards
var field_z = 0  # Fixed z-axis position
var placed_3d_cards = []
var selected_cards = []
var attack_mode = false
var ressources = {"Holz" : 30, "Stein" : 30, "Metall" : 30, "Amethyst" : 0, "Gold" : 0}
func _ready():
	print("option_btn:", option_btn)
	print("weiter_btn:", weiter_btn)
	option_btn.option_pressed.connect(_on_option_pressed)
func set_attack_mode():
	if GameStateWorld.current_phase == GameStateWorld.Phase.FIGHTING:
		if selected_cards.size() > 0:
		
			option_btn.text = "Mit " + str(selected_cards.size()) + " Truppen angreifen"
			option_btn.visible = true
			option_btn.preview = false
			weiter_btn.visible = false
		else:
			option_btn.visible = false
			weiter_btn.visible = true
			option_btn.preview = true
func _on_option_pressed():
	if GameStateWorld.current_phase == GameStateWorld.Phase.FIGHTING:
		if selected_cards.size() > 0:
			print(selected_cards)
			GameStateWorld.player_attacking(player, selected_cards)
			option_btn.visible = false
			weiter_btn.visible = true
			GameStateWorld.next_phase()
