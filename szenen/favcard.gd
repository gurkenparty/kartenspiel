extends Sprite3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
# Select a random card from the user_cards array
	if GameStats.user_cards.size() - 1 < 0:
		self.texture = load("res://assets/characters/mensch/1/Knappe/knappe.png")
	else:
# Get a random index from the user's cards
		var random_card_index = randi_range(0, GameStats.user_cards.size() - 1)

# Get the name of the random card
		var card_name = GameStats.user_cards[random_card_index]

# Look up the card in the GlobalLibrary
		var selected_card = GlobalLibrary.cards[card_name]

# Access the texture of the selected card
		self.texture = selected_card["texture"]  # This will automatically load the texture since it is preloaded

# Optionally, you can also load the draggable scene if needed
