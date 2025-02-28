extends Node3D

var deck = [
	{"texture": preload("res://assets/characters/mensch/1/Knappe/knappe.png"), "draggable_scene": preload("res://szenen/welt/3d/card/mensch/1/Knappe/Knappe.tscn")},
	{"texture": preload("res://assets/characters/mensch/1/Knappe/knappe.png"), "draggable_scene": preload("res://szenen/welt/3d/card/mensch/1/Knappe/Knappe.tscn")},
	{"texture": preload("res://assets/characters/mensch/1/Knappe/knappe.png"), "draggable_scene": preload("res://szenen/welt/3d/card/mensch/1/Knappe/Knappe.tscn")},
	{"texture": preload("res://assets/characters/mensch/1/Knappe/knappe.png"), "draggable_scene": preload("res://szenen/welt/3d/card/mensch/1/Knappe/Knappe.tscn")},
	
	{"texture": preload("res://assets/characters/mensch/1/Landwirtin/Landwirtin.png"), "draggable_scene": preload("res://szenen/welt/3d/card/mensch/1/Landwirtin/Landwirtin.tscn")},
	{"texture": preload("res://assets/characters/mensch/1/Landwirtin/Landwirtin.png"), "draggable_scene": preload("res://szenen/welt/3d/card/mensch/1/Landwirtin/Landwirtin.tscn")},
	{"texture": preload("res://assets/characters/mensch/1/Landwirtin/Landwirtin.png"), "draggable_scene": preload("res://szenen/welt/3d/card/mensch/1/Landwirtin/Landwirtin.tscn")},
	{"texture": preload("res://assets/characters/mensch/1/Landwirtin/Landwirtin.png"), "draggable_scene": preload("res://szenen/welt/3d/card/mensch/1/Landwirtin/Landwirtin.tscn")},
	{"texture": preload("res://assets/characters/mensch/1/Joker/Joker.png"), "draggable_scene": preload("res://szenen/welt/3d/card/mensch/1/Joker/Joker.tscn")},
	{"texture": preload("res://assets/characters/mensch/2/Ritter/Ritter.png"), "draggable_scene": preload("res://szenen/welt/3d/card/mensch/2/Ritter/ritter.tscn")},
	{"texture": preload("res://assets/characters/mensch/2/Assasine/Assasine.png"), "draggable_scene": preload("res://szenen/welt/3d/card/mensch/2/Assasine/Assasine.tscn")},
	{"texture": preload("res://assets/characters/mensch/3/Grundbesitzerin/Grundbesitzerin.png"), "draggable_scene": preload("res://szenen/welt/3d/card/mensch/3/Grundbesitzerin/Grundbesitzerin.tscn")},
	{"texture": preload("res://assets/characters/mensch/4/General_der_1_Legion/General.png"), "draggable_scene": preload("res://szenen/welt/3d/card/mensch/4/general_der_1_legion.tscn")},
	{"texture": preload("res://assets/characters/mensch/4/Graf_Zacharias/Zacharias.png"), "draggable_scene": preload("res://szenen/welt/3d/card/mensch/4/graf_zacharias.tscn")},
	{"texture": preload("res://assets/characters/mensch/5/Gerd/Gerd.png"), "draggable_scene": preload("res://szenen/welt/3d/card/mensch/5/Koenig_Gerd/koenig_gerd.tscn")},
	{"texture": preload("res://assets/characters/mensch/6/Urus/Urus.png"), "draggable_scene": preload("res://szenen/welt/3d/card/mensch/6/Lord_Urus/Lord_Urus.tscn")}
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
