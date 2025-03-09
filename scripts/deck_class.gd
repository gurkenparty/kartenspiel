extends Resource
class_name Deck

@export var deck_name: String
@export var preview: Texture
@export var cards: Array = []
var cards_playable: Array = []

# Constructor (_init is called when 'Card.new()' is used)
func _init(deck_name: String = "", preview: Texture = null, cards:Array = []):
	deck_name = deck_name
	preview = preview
	cards = cards
	cards_playable = cards

func add_card(card:String):
	if self.cards.size() <= 60:
		self.cards.append(card)
		cards_playable = cards
		
func remove_card(card:String):
	if self.cards.size() > 0:
		self.cards.erase(card)
		cards_playable = cards
	
func draw_card() -> Dictionary:
	if self.cards_playable.size() > 0:
		var random_index = randi() % self.cards_playable.size()  # Pick a random index
		var card_name = self.cards_playable[random_index]  # Get the card name
		self.cards_playable.remove_at(random_index)  # Remove card name from deck

		# Fetch the actual card data from the global library
		print("Card Lib: " + str(GlobalLibrary.cards))
		if GlobalLibrary.cards.has(card_name):  # Check if card exists
			return GlobalLibrary.cards[card_name]  # Return the card data
		else:
			print("Error: Card '" + card_name + "' not found in GlobalLibrary!")
			return {}
	else:
		print("Deck is empty!")
		return {}  # Return empty dictionary if no cards are left
		
func shuffle_deck():
	self.cards_playable.shuffle()
