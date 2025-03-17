extends Node3D

var deck = ["Knappe","Knappe","Knappe","Knappe"]  # Stores the card names
signal ready_loaded
func _ready():
	if GameStats.selected_deck == null:
		GameStats.selected_deck = GameStats.decks[0]
	deck = GameStats.selected_deck.cards
	shuffle_deck()  # Shuffle at start
	ready_loaded.emit()

# Function to draw a card, randomly pick one and remove it from the deck
func draw_card() -> Dictionary:
	if deck.size() > 0:
		var random_index = randi() % deck.size()  # Pick a random index
		var card_name = deck[random_index]  # Get the card name
		deck.remove_at(random_index)  # Remove card name from deck

		# Fetch the actual card data from the global library
		if GlobalLibrary.cards.has(card_name):  # Check if card exists
			return GlobalLibrary.cards[card_name]  # Return the card data
		else:
			print_debug("Error: Card '" + card_name + "' not found in GlobalLibrary!")
			return {}
	else:
		print_debug("Deck is empty!")
		return {}  # Return empty dictionary if no cards are left

# Function to shuffle the deck
func shuffle_deck():
	deck.shuffle()  # Shuffle the deck for random order
