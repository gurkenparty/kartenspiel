extends Control

@export var card_scene: PackedScene  # The Karte2D scene
@export var hand_container: HBoxContainer  # UI container for cards
@export var deck: Node3D  # Reference to the Deck node

signal card_played(card)  # Signal when a card is played
signal request_draw_card  # Signal to request a new card from the deck

func _ready():
	spawn_hand_cards(5)  # Spawn initial 5 cards

	# Listen for phase changes from GameState
	GameStateWorld.phase_changed.connect(_on_phase_changed)

	# Connect the draw request signal
	request_draw_card.connect(_on_request_draw_card)

# Function to handle drawing a card when a card requests it
func _on_request_draw_card():
	if hand_container.get_child_count() < 5:
		print("A card requested a draw! Requesting from deck.")
		if deck:
			var new_card_data = deck.draw_card()  # Ask deck for a new card
			if new_card_data:
				spawn_card(new_card_data)

# Function to spawn a single card from given data
func spawn_card(card_data: Dictionary):
	var new_card = card_scene.instantiate()
	if new_card is Button:
		new_card.cardimg = card_data["texture"]
		new_card.draggable = card_data["draggable_scene"]
		new_card.card_placed.connect(_on_card_placed)
		hand_container.add_child(new_card)

# Function to initially fill the hand
func spawn_hand_cards(amount: int):
	for i in range(amount):
		_on_request_draw_card()

# Function to remove a played card from hand
func _on_card_placed(card: Button):
	print("Card placed:", card.name)
	hand_container.remove_child(card)

	# Move the card to the world
	var world_parent = get_tree().get_root().find_child("Main", true, false)
	if world_parent:
		world_parent.add_child(card)
		print("Card: " + str(card) + " added to: " + str(world_parent))

func _on_phase_changed(new_phase: int):
	print("Game State changed on Hand to phase: ", new_phase)  # Debug signal reception
	if new_phase == GameStateWorld.Phase.DRAWING:
		spawn_hand_cards(1)
