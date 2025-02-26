extends Node

var placed_cards = {}  # Stores placed card positions
var field_start_x = -9.0  # Left-most position on the field
var field_spacing = 3  # Distance between cards
var field_z = 0  # Fixed z-axis position

var ressources = {"Holz" : 0, "Stein" : 0, "Metall" : 0, "Amethyst" : 0, "Gold" : 0}
