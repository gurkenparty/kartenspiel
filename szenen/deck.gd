extends Node3D

var deck = [
	"Knappe", "Knappe", "Knappe", "Knappe",
	"Landwirtin", "Landwirtin", "Landwirtin", "Landwirtin",
	"Joker", "Ritter", "Assasine", "Grundbesitzerin",
	"Graf_Zacharias", "Gerd", "Urus", "Bär",
	"Gift", "Späher", "Muti", "Stratege", "Meister",
	"Unge", "Hauer", "Zerfleischer", "EF", "RO", "Kirill", "Blumen", "Erde", 
	"Feuer", "Glas" , "Licht", "Natur", "Schatten", "Stahl", "Wasser", "Xera", "TW", "BB", "EK", "Vet", "Sch"
]  # Stores the card names

func _ready():
	# Define the deck with card names
	shuffle_deck()  # Shuffle at start

# Function to draw a card, randomly pick one and remove it from the deck
func draw_card() -> Dictionary:
	if deck.size() > 0:
		var random_index = randi() % deck.size()  # Pick a random index
		var card_name = deck[random_index]  # Get the card name
		deck.remove_at(random_index)  # Remove card name from deck

		# Fetch the actual card data from the global library
		print_debug("Card Lib: " + str(GlobalLibrary.cards))
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
