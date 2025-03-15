extends Control

@export var card_scene: PackedScene  # The Karte2D scene
@export var hand_container: HBoxContainer  # UI container for cards
@export var deck: Node3D  # Reference to the Deck node
@export var player_number: int
@export var GameState: Node3D

signal card_played(card)  # Signal when a card is played
signal request_draw_card  # Signal to request a new card from the deck
signal card_3d_effector(card3d)

func _ready():
	player_number = 2
	spawn_hand_cards(5)  # Spawn initial 5 cards
	GameStateWorld.phase_changed.connect(_on_phase_changed)
	GameStateWorld.turn_changed.connect(_on_turn_changed)
	request_draw_card.connect(_on_request_draw_card)

func _on_request_draw_card():
	if self.get_child_count() < 5:
		if deck:
			var new_card_data = deck.draw_card()
			if new_card_data:
				spawn_card(new_card_data)

func spawn_card(card_data: Dictionary):
	var new_card = card_scene.instantiate()
	if new_card is Button:
		new_card.cardimg = card_data["texture"]
		new_card.draggable = card_data["draggable_scene"]
		new_card.card_placed.connect(_on_card_placed)
		hand_container.add_child(new_card)
		new_card.hand = self
		new_card.GameState = GameState
		new_card.player_number = player_number

func spawn_hand_cards(amount: int):
	for i in range(amount):
		_on_request_draw_card()

func _on_card_placed(card: Button, card3d: Node3D):
	hand_container.remove_child(card)
	card_3d_effector.emit(card3d)
	var world_parent = get_tree().get_root().find_child("Game3D", true, false)
	if world_parent:
		world_parent.add_child(card)
		GameState.placed_3d_cards.append(card3d)

func _on_phase_changed(new_phase: int):
	if new_phase == GameStateWorld.Phase.DRAWING and GameStateWorld.current_player == player_number:
		spawn_hand_cards(1)
		
	elif new_phase == GameStateWorld.Phase.FIGHTING and GameStateWorld.current_player == player_number:
		pass
	elif new_phase == GameStateWorld.Phase.PLAYING and GameStateWorld.current_player == player_number:
		play_random_card()
		GameStateWorld.next_phase()

func _on_turn_changed(current_player:int):
	if current_player == player_number:
		play_random_card()

func play_random_card():
	print_debug("playing random card")
	if self.get_child_count() > 0:
		var card = self.get_child(0)
		simulate_card_placement(card)

func simulate_card_placement(card: Button):
	if card and not card.placed:
		print("AI attempting to place card: " + str(card.name))
		var fake_collider = GameState.get_valid_placement_area()
		if fake_collider:
			card.is_dragging = true
			card.local_draggable.visible = true
			card.local_draggable.global_position = Vector3(fake_collider.global_position.x, 2.0, fake_collider.global_position.z)
			card.emit_signal("card_placed", card, card.local_draggable)
			print("AI placed card: " + str(card.name))
