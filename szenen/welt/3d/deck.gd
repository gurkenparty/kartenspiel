extends Node3D

var deck = [
	{"texture": preload("res://assets/characters/mensch/1/Knappe/knappe.png"), "draggable_scene": preload("res://szenen/welt/3d/card/mensch/1/Knappe/knappe.tscn")},
	{"texture": preload("res://assets/characters/mensch/1/Knappe/knappe.png"), "draggable_scene": preload("res://szenen/welt/3d/card/mensch/1/Knappe/knappe.tscn")},
	{"texture": preload("res://assets/characters/mensch/1/Knappe/knappe.png"), "draggable_scene": preload("res://szenen/welt/3d/card/mensch/1/Knappe/knappe.tscn")},
	{"texture": preload("res://assets/characters/mensch/1/Knappe/knappe.png"), "draggable_scene": preload("res://szenen/welt/3d/card/mensch/1/Knappe/knappe.tscn")},
	
	{"texture": preload("res://assets/characters/mensch/1/Landwirtin/Landwirtin.png"), "draggable_scene": preload("res://szenen/welt/3d/card/mensch/1/Landwirtin/Landwirtin.tscn")},
	{"texture": preload("res://assets/characters/mensch/1/Landwirtin/Landwirtin.png"), "draggable_scene": preload("res://szenen/welt/3d/card/mensch/1/Landwirtin/Landwirtin.tscn")},
	{"texture": preload("res://assets/characters/mensch/1/Landwirtin/Landwirtin.png"), "draggable_scene": preload("res://szenen/welt/3d/card/mensch/1/Landwirtin/Landwirtin.tscn")},
	{"texture": preload("res://assets/characters/mensch/1/Landwirtin/Landwirtin.png"), "draggable_scene": preload("res://szenen/welt/3d/card/mensch/1/Landwirtin/Landwirtin.tscn")},
	{"texture": preload("res://assets/characters/mensch/1/Joker/Joker.png"), "draggable_scene": preload("res://szenen/welt/3d/card/mensch/1/Joker/Joker.tscn")},
	{"texture": preload("res://assets/characters/mensch/2/Ritter/Ritter.png"), "draggable_scene": preload("res://szenen/welt/3d/card/mensch/2/Ritter/ritter.tscn")}
]

func _ready():
	shuffle_deck()

# Function to draw a card, randomly pick one and remove it from the deck
func draw_card() -> Dictionary:
	if deck.size() > 0:
		var random_index = randi() % deck.size()  # Pick a random index
		var card = deck[random_index]  # Get the card at that index
		deck.remove_at(random_index)  # Correct method to remove by index
		return card
	else:
		print("Deck is empty!")
		return {}  # Return empty dictionary if no cards are left

# Function to shuffle the deck
func shuffle_deck():
	deck.shuffle()  # Shuffle the deck for random order
