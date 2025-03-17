extends Node3D

@export var player_number: int = 2
@export var card_scene: PackedScene  # The Karte2D scene
@export var hand = []
@export var deck: Node3D  # Reference to the Deck node
var local_draggable
var cost: Dictionary
signal card_played(card)  # Signal when a card is played
signal request_draw_card  # Signal to request a new card from the deck
signal card_3d_effector(card3d)

var selected_cards = []
var placed_cards = {}    # Stores AI-placed card references
var ressources = {"Holz": 30, "Stein": 30, "Metall": 30, "Amethyst": 0, "Gold": 0}
var field_start_x = 9.0  # AI's card placement starting position
var field_spacing = -3.0  # Distance between placed cards
var field_z = -1.0  # Fixed Z position for AI's side

func _ready() -> void:
	deck = GameStats.selected_deck
	print_debug("Bot spawned")
	GameStateWorld.phase_changed.connect(_on_phase_changed)
	GameStateWorld.turn_changed.connect(_on_turn_changed)
	print_debug("Bot on deck loaded")
	if deck.has_method("draw_card"):
		print_debug("Deck loaded, attempting to draw cards.")
		for i in range(5):
			var drawn_card = deck.draw_card()  # Make sure the draw_card function is available
			if drawn_card:
				hand.append(drawn_card)
				print_debug("Bot drew hand card: " + str(drawn_card))
			else:
				print_debug("Failed to draw card.")
	else:
		print_debug("Deck does not have the draw_card method.")

func _on_phase_changed(new_phase):
	if new_phase == GameStateWorld.Phase.DRAWING and GameStateWorld.current_player == player_number:
		deck.draw_card()
	elif new_phase == GameStateWorld.Phase.FIGHTING and GameStateWorld.current_player == player_number:
		attack_with_all_cards()
	elif new_phase == GameStateWorld.Phase.PLAYING and GameStateWorld.current_player == player_number and hand.size()>0:
		hand.shuffle()  # Shuffle cards before playing
		var card_element = hand[0]
		hand.remove_at(0)
		local_draggable = card_element["draggable_scene"]
		var cardimg = card_element["texture"]
		var local_draggable_instance = local_draggable.instantiate()
		
		# Make sure we can place the card based on the cost
		if not can_place_card(local_draggable_instance.cost):
			print("Cant place card, resetting")
			return  # Stop further execution if resources are insufficient

		# Deduct resources
		for res in local_draggable_instance.cost.keys():
			ressources[res] -= local_draggable_instance.cost[res]

		# Get the card key and calculate the position
		var card_key = cardimg.resource_path
		var x_position = field_start_x
		var y_position = 0.1
		var z_position = field_z

		# Stack the cards based on their card type (card_key)
		if placed_cards.has(card_key):
			var stack_count = placed_cards[card_key].size()
			# Adjust position by stack count
			x_position = placed_cards[card_key][0].x + (stack_count * 0.2)
		else:
			# First card of this type, position according to the overall field spacing
			x_position += field_spacing * placed_cards.size()

		var final_position = Vector3(x_position, y_position, z_position)
		add_child(local_draggable_instance)

		# Move the card to the final position smoothly with tweening
		var placing_tween = create_tween()
		placing_tween.tween_property(local_draggable_instance, "position", final_position, 0.2)

		# Add to the placed cards dictionary, initializing the list if it's not already present
		if not placed_cards.has(card_key):
			placed_cards[card_key] = []  # Initialize an empty list if it's the first card of this type
		placed_cards[card_key].append(final_position)  # Store the final position of this card

		# Update card properties and add it to the scene
		local_draggable_instance.played = true
		local_draggable_instance.add_to_group("Player2")
		local_draggable_instance.cardimg_file = cardimg
		local_draggable_instance.player_number = player_number
		local_draggable_instance.GameState = self
		local_draggable_instance.cam = GameStateWorld.player_1_cam
		local_draggable_instance.weiter_btn = GameStateWorld.weiter_btn
		local_draggable_instance.option_btn = GameStateWorld.option_btn
		local_draggable_instance.add_to_group("feld")
		
		# Log the placement for debugging
		print_debug("Card placed: " + str(local_draggable_instance.name) + " at position: " + str(final_position))
		
		# Remove the card from the local child before adding it to the global scene
		self.remove_child(local_draggable_instance)

		# Emit a signal that a card has been placed and update the scene
		card_3d_effector.emit(local_draggable_instance)
		var world_parent = get_tree().get_root().find_child("Game3D", true, false)
		if world_parent:
			world_parent.add_child(local_draggable_instance)
			
func attack_with_all_cards():
	print_debug("Bot's turn: Attacking with all cards on the field.")
	
	# Loop through all cards on the field and select them
	for card in get_tree().get_nodes_in_group("feld"):
		
		print_debug("Bot recognising: " + card.name + " in feld")
		if "Player2" in card.get_groups():
			print_debug("Bot recognising: " + card.name + " in Player2")
		# Make sure the card is not already selected
			if not card.selected:
			# Select the card (similar to player selection)
				apply_attack(card)
		# Perform the attack with the selected card
		GameStateWorld.next_phase()
	# Once all cards are selected and attacked, end the bot's turn
func set_attack_mode():
	pass
func apply_attack(card):
	print_debug("Bot applied attack")
	GameStateWorld.player_1_hp -= card.angriff
	pass

func can_place_card(cost) -> bool:
	for res in cost.keys():
		if ressources[res] < cost[res]:
			print("Not enough " + res)
			return false
	return true
	
func _on_turn_changed(new_player):
	pass

func get_valid_placement_position():
	return Vector3(field_start_x + field_spacing * placed_cards.size(), 1.0, field_z)
