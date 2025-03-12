extends Control

@export var card_scene: PackedScene  # The Karte2D scene
@export var hand_container: HBoxContainer  # UI container for cards
@export var deck: Node3D  # Reference to the Deck node
@export var option_btn : Button
@export var weiter_btn : Button
@export var player_number: int
@export var GameState: Node3D

signal card_played(card)  # Signal when a card is played
signal request_draw_card  # Signal to request a new card from the deck
signal card_3d_effector(card3d)

func _ready():
	player_number = GameState.player_number
	spawn_hand_cards(5)  # Spawn initial 5 cards
	self.global_position += Vector2(0, 100)
	# Listen for phase changes from GameState
	GameStateWorld.phase_changed.connect(_on_phase_changed)
	GameStateWorld.turn_changed.connect(_on_turn_changed)
	# Connect the draw request signal
	request_draw_card.connect(_on_request_draw_card)
	print_debug("Current Player is: " + str(GameStateWorld.current_player) + " and I, " + str(self.name) + " am: " +str(player_number))

# Function to handle drawing a card when a card requests it
func _on_request_draw_card():
	if hand_container.get_child_count() < 5:
		print_debug("A card requested a draw! Requesting from " + str(player_number))
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
		new_card.option_btn = option_btn
		new_card.weiter_btn = weiter_btn
		new_card.hand = self
		new_card.GameState = GameState
		print_debug("Gave new card player number: " + str(player_number))
		new_card.player_number = player_number
		print_debug("Karte2d got the following game State: " + str(GameState))

# Function to initially fill the hand
func spawn_hand_cards(amount: int):
	for i in range(amount):
		_on_request_draw_card()

# Function to remove a played card from hand
func _on_card_placed(card: Button, card3d: Node3D):
	print_debug("Card placed:", card.name)
	hand_container.remove_child(card)
	card_3d_effector.emit(card3d)

	# Move the card to the world
	var world_parent = get_tree().get_root().find_child("Game3D", true, false)
	if world_parent:
		world_parent.add_child(card)
		print_debug("Card: " + str(card) + " added to: " + str(world_parent))
		GameState.placed_3d_cards.append(card3d)

func _on_phase_changed(new_phase: int):
	print_debug("Game State changed on Hand to phase: ", new_phase)  # Debug signal reception
	if new_phase == GameStateWorld.Phase.DRAWING and GameStateWorld.current_player == player_number:
		self.global_position -= Vector2(0, 100)
		spawn_hand_cards(1)
	elif  new_phase == GameStateWorld.Phase.FIGHTING and GameStateWorld.current_player == player_number:
		self.global_position += Vector2(0, 100)
		
func _on_turn_changed(current_player:int):
	if current_player != player_number:
		self.visible = false
	else:
		self.visible = true
