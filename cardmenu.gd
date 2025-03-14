extends Control

signal closing_editor()
@export var cards: Array
@export var card_preview_scene: PackedScene = load("res://szenen/card_preview.tscn")  # Scene for deck preview
var z_spawn:int = 72
var default_x:int = 55
var default_x_name:int
var default_y_name:int
@export var card_wrapper: Control  # Holds all card previews
@export var scroll_container:ScrollContainer
@export var card_in_deck_container:Control
@export var reference_card_name: Button
@export var deck_name_panel:LineEdit
@export var deck_name:String
@export var deck: Deck
var cards_in_deck = []
@export var scroll_names_cont:ScrollContainer

func _ready() -> void:
	# Create ScrollContainer
	scroll_container.name = "ScrollContainer"
	scroll_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	scroll_container.size_flags_vertical = Control.SIZE_EXPAND_FILL
	#add_child(scroll_container)
	default_x_name = reference_card_name.global_position.x
	default_y_name = reference_card_name.global_position.y
	# Create Wrapper (for positioning manually)
	card_wrapper.name = "CardWrapper"
	card_wrapper.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	card_wrapper.custom_minimum_size = Vector2(1700, 900)  # Make sure it’s big enough to scroll
	scroll_container.add_child(card_wrapper)
	deck_name_panel.text = deck_name
	cards = GameStats.user_cards
	cards_in_deck = deck.cards

	refresh_card_display()

# Function to refresh the deck display in the menu
func refresh_card_display():
	# Clear all existing UI elements
	for child in card_wrapper.get_children():
		child.queue_free()
	for child in card_in_deck_container.get_children():
		if child.name != "reference":
			child.queue_free()
		reference_card_name.global_position = Vector2(default_x_name, default_y_name)
			
	var reference_card_scene = card_preview_scene.instantiate()
	reference_card_scene.global_position = Vector2(default_x, z_spawn)
	reference_card_scene.card_pressed.connect(_on_card_pressed)
	card_wrapper.add_child(reference_card_scene)

	var card_data:Dictionary
	for card in cards:
		if GlobalLibrary.cards.has(card):
			card_data = GlobalLibrary.cards[card]

		var card_preview_instance = card_preview_scene.instantiate()
		card_preview_instance.change_card_name(card)
		card_preview_instance.change_preview(card_data["texture"])
		card_preview_instance.card_pressed.connect(_on_card_pressed)
		card_wrapper.add_child(card_preview_instance)

		card_preview_instance.global_position = reference_card_scene.global_position
		reference_card_scene.visible = false

		# Adjust positioning (same as before)
		var moving_distance = 290
		if reference_card_scene.global_position.x + moving_distance > 1500:
			reference_card_scene.global_position.y += 400
			reference_card_scene.global_position.x = default_x
		else:
			reference_card_scene.global_position.x += moving_distance

	# Ensure the wrapper resizes properly (so ScrollContainer works)
	card_wrapper.custom_minimum_size.y = reference_card_scene.global_position.y + 350
	for card_name in cards_in_deck:
		scroll_names_cont.add_item(card_name)

# Callback when a card is pressed
func _on_card_pressed(element:Button):
	cards_in_deck.append(element.card_name)
	self.cards.erase(element.card_name)
	refresh_card_display()
	
	
	


func _on_finished_pressed() -> void:
	deck.deck_name = deck_name_panel.text
	deck.cards = self.cards_in_deck
	self.visible = false
	closing_editor.emit()
	
