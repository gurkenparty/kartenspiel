extends Node
@export var option_btn: Button 
@export var weiter_btn: Button
@export var player: int
@onready var player_1_base: Control = get_tree().get_root().find_child("Basis", true, false)
@onready var player_2_base: Control = get_tree().get_root().find_child("Basis2", true, false)
var placed_cards = {}  # Stores placed card positions
var field_start_x = -9.0  # Left-most position on the field
var field_spacing = 3  # Distance between cards
var field_z = -2  # Fixed z-axis position
var placed_3d_cards = []
var selected_cards = []
var attack_mode = false
var ressources = {"Holz" : 30, "Stein" : 30, "Metall" : 30, "Amethyst" : 0, "Gold" : 0}
func _ready():
	print("option_btn:", option_btn)
	print("weiter_btn:", weiter_btn)
	print("Current Player is: " + str(GameStateWorld.current_player) + " and I, " + str(self.name) + " am: " +str(player))
	if player == 2:
		print("Current Player is: " + str(GameStateWorld.current_player) + " and I, " + str(self.name) + " am: " +str(player))
		field_start_x = 9
		field_spacing = -3
		field_z = 2
	option_btn.option_pressed.connect(_on_option_pressed)
func set_attack_mode():
	print("Current Player is: " + str(GameStateWorld.current_player) + " and I, " + str(self.name) + " am: " +str(player))
	if GameStateWorld.current_phase == GameStateWorld.Phase.FIGHTING and player == GameStateWorld.current_player:
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
			
func player_attacking(player:int, attack:Array):
	if player == 1:
		for card in attack:
			player_2_base.change_hp_base(card.angriff*-1)
	elif player == 2:
		for card in attack:
			player_1_base.change_hp_base(card.angriff*-1)
			
			
