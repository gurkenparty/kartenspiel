extends Control

@export var cards: Array
@export var card_preview_scene: PackedScene = load("res://szenen/card_preview.tscn")  # Scene for deck preview
var card_container: GridContainer  # Container for cards

func _ready() -> void:
	# Create ScrollContainer and GridContainer dynamically
	var scroll = ScrollContainer.new()
	scroll.anchors_preset = Control.PRESET_FULL_RECT  # Make it fill the parent
	scroll.name = "ScrollContainer"
	add_child(scroll)

	card_container = GridContainer.new()
	card_container.columns = 5  # Adjust as needed
	card_container.name = "CardContainer"
	card_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	card_container.size_flags_vertical = Control.SIZE_EXPAND_FILL
	scroll.add_child(card_container)

	refresh_card_display()

# Function to refresh the deck display in the menu
func refresh_card_display():
	# Clear all existing UI elements
	for child in card_container.get_children():
		child.queue_free()
			
	# Iterate over each card and create a UI element for it
	for card in cards:
		if GlobalLibrary.cards.has(card):
			var card_data = GlobalLibrary.cards[card]
			var card_preview_instance = card_preview_scene.instantiate()
			card_preview_instance.change_card_name(card)
			card_preview_instance.change_preview(card_data["texture"])
			card_preview_instance.card_pressed.connect(_on_card_pressed)
			card_container.add_child(card_preview_instance)

# Callback when a card is pressed
func _on_card_pressed(element:Button):
	print_debug(element.name + " pressed")
