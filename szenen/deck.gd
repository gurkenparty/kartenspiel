extends Node3D

var deck = [
	{"texture": preload("res://assets/characters/mensch/1/Knappe/knappe.png"), "draggable_scene": preload("res://szenen/card/mensch/1/Knappe/Knappe.tscn")},
	{"texture": preload("res://assets/characters/mensch/1/Knappe/knappe.png"), "draggable_scene": preload("res://szenen/card/mensch/1/Knappe/Knappe.tscn")},
	{"texture": preload("res://assets/characters/mensch/1/Knappe/knappe.png"), "draggable_scene": preload("res://szenen/card/mensch/1/Knappe/Knappe.tscn")},
	{"texture": preload("res://assets/characters/mensch/1/Knappe/knappe.png"), "draggable_scene": preload("res://szenen/card/mensch/1/Knappe/Knappe.tscn")},
	{"texture": preload("res://assets/characters/mensch/1/Landwirtin/Landwirtin.png"), "draggable_scene": preload("res://szenen/card/mensch/1/Landwirtin/Landwirtin.tscn")},
	{"texture": preload("res://assets/characters/mensch/1/Landwirtin/Landwirtin.png"), "draggable_scene": preload("res://szenen/card/mensch/1/Landwirtin/Landwirtin.tscn")},
	{"texture": preload("res://assets/characters/mensch/1/Landwirtin/Landwirtin.png"), "draggable_scene": preload("res://szenen/card/mensch/1/Landwirtin/Landwirtin.tscn")},
	{"texture": preload("res://assets/characters/mensch/1/Landwirtin/Landwirtin.png"), "draggable_scene": preload("res://szenen/card/mensch/1/Landwirtin/Landwirtin.tscn")},
	{"texture": preload("res://assets/characters/mensch/1/Joker/Joker.png"), "draggable_scene": preload("res://szenen/card/mensch/1/Joker/Joker.tscn")},
	{"texture": preload("res://assets/characters/mensch/2/Ritter/Ritter.png"), "draggable_scene": preload("res://szenen/card/mensch/2/Ritter/ritter.tscn")},
	{"texture": preload("res://assets/characters/mensch/2/Assasine/Assasine.png"), "draggable_scene": preload("res://szenen/card/mensch/2/Assasine/Assasine.tscn")},
	{"texture": preload("res://assets/characters/mensch/3/Grundbesitzerin/Grundbesitzerin.png"), "draggable_scene": preload("res://szenen/card/mensch/3/Grundbesitzerin/Grundbesitzerin.tscn")},
	{"texture": preload("res://assets/characters/mensch/4/Graf_Zacharias/Zacharias.png"), "draggable_scene": preload("res://szenen/card/mensch/4/Graf_Zacharias/graf_zacharias.tscn")},
	{"texture": preload("res://assets/characters/mensch/5/Gerd/Gerd.png"), "draggable_scene": preload("res://szenen/card/mensch/5/Koenig_Gerd/koenig_gerd.tscn")},
	{"texture": preload("res://assets/characters/mensch/6/Urus/Urus.png"), "draggable_scene": preload("res://szenen/card/mensch/6/Lord_Urus/Lord_Urus.tscn")},
	{"texture": preload("res://assets/characters/kobold/1/Bär/Bär.png"), "draggable_scene": preload("res://szenen/card/kobold/1/Bär/bär.tscn")},
	{"texture": preload("res://assets/characters/kobold/2/Gift/Gift.png"), "draggable_scene": preload("res://szenen/card/kobold/2/Gift/gift.tscn")},
	{"texture": preload("res://assets/characters/kobold/3/Späher/Späher.png"), "draggable_scene": preload("res://szenen/card/kobold/3/Späher/späher.tscn")},
	{"texture": preload("res://assets/characters/kobold/4/Muti/Muti.png"), "draggable_scene": preload("res://szenen/card/kobold/4/Muti/Muti.tscn")},
	{"texture": preload("res://assets/characters/kobold/5/Stratege/Stratege.png"), "draggable_scene": preload("res://szenen/card/kobold/5/Stratege/Stratege.tscn")},
	{"texture": preload("res://assets/characters/kobold/6/Meister/Meister.png"), "draggable_scene": preload("res://szenen/card/kobold/6/Meister/Meister.tscn")},
	{"texture": preload("res://assets/characters/ork/1/Ungelehrter/Ungelehrter.png"), "draggable_scene": preload("res://szenen/card/Ork/1/Ungelehrter/Unge.tscn")},
	{"texture": preload("res://assets/characters/ork/2/hauer/hauer.png"), "draggable_scene": preload("res://szenen/card/Ork/2/Hauer/Hauer.tscn")},
	{"texture": preload("res://assets/characters/ork/3/Zerfleischer/Cropped.png"), "draggable_scene": preload("res://szenen/card/Ork/3/Zerfleischer/Zerfleischer.tscn")},
	{"texture": preload("res://assets/characters/ork/4/EF/EF.png"), "draggable_scene": preload("res://szenen/card/Ork/4/FetterReiter/EF.tscn")},
	{"texture": preload("res://assets/characters/ork/5/RO/RO.png"), "draggable_scene": preload("res://szenen/card/Ork/5/OgerOrk/RO.tscn")},
	{"texture": preload("res://assets/characters/ork/6/Kirill/Kirill.png"), "draggable_scene": preload("res://szenen/card/Ork/6/Kirill/Kirill.tscn")}
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
