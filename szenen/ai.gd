extends Node3D

@export var player_number: int
@export var player_base: Control

var placed_cards = []  # Stores AI-placed card references
var ressources = {"Holz": 30, "Stein": 30, "Metall": 30, "Amethyst": 0, "Gold": 0}
var field_start_x = 9.0  # AI's card placement starting position
var field_spacing = -3.0  # Distance between placed cards
var field_z = -1.0  # Fixed Z position for AI's side

func attack_if_possible():
	if placed_cards.size() > 0:
		print("AI attacking with", placed_cards.size(), "units")
		player_base.change_hp_base(-5 * placed_cards.size())  # Example attack logic
	GameStateWorld.next_phase()

func get_valid_placement_position():
	return Vector3(field_start_x + field_spacing * placed_cards.size(), 1.0, field_z)
