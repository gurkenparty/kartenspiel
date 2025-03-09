extends Control

@export var deckcontainer: GridContainer  # GridContainer for layout
@export var deck_preview_scene: PackedScene = load("res://szenen/element_preview.tscn")  # Scene for deck preview
@export var new_deck_button_scene: PackedScene = load("res://szenen/element_preview.tscn")  # Scene for "New Deck" button
@export var columns: int = 2  # Number of columns in the grid (adjust as needed)

func _ready() -> void:
	refresh_deck_display()

# Function to refresh the deck display in the menu
func refresh_deck_display():
	# Clear all existing UI elements
	for child in deckcontainer.get_children():
		child.queue_free()

	# Set the number of columns for the GridContainer
	deckcontainer.columns = columns

	# Iterate over each deck in GameStats.decks and create a UI for it
	for deck in GameStats.decks:
		# Create a container for each deck's preview
		var deck_ui_container = Button.new()  # Button to act as the clickable deck container
		deck_ui_container.custom_minimum_size = Vector2(150, 150)  # Set a fixed minimum size for the button
		deck_ui_container.size_flags_horizontal = Control.SIZE_SHRINK_CENTER  # Prevent expansion in horizontal direction
		deck_ui_container.size_flags_vertical = Control.SIZE_SHRINK_CENTER    # Prevent expansion in vertical direction

		deckcontainer.add_child(deck_ui_container)  # Add the container to the GridContainer
		
		# Create a VBoxContainer to hold the preview and label inside the button
		var deck_ui_sort = VBoxContainer.new()
		deck_ui_container.add_child(deck_ui_sort)
		
		# Create the Sprite2D for the deck's preview
		var deck_preview_sprite = Sprite2D.new()
		deck_preview_sprite.texture = deck.preview  # Assign the deck's preview texture
		deck_ui_sort.add_child(deck_preview_sprite)  # Add sprite to VBoxContainer
		
		# Create a Label to show the deck name
		var deck_ui_label = Label.new()
		deck_ui_label.text = deck.name  # Use deck.name as the label text
		deck_ui_sort.add_child(deck_ui_label)  # Add label to VBoxContainer

	# Ensure the "New Deck" button is always the last item in the container
	var new_deck_button = Button.new()  # Instantiate the new deck button
	new_deck_button.custom_minimum_size = Vector2(150, 150)  # Set a fixed size for the button
	new_deck_button.size_flags_horizontal = Control.SIZE_SHRINK_CENTER  # Prevent expansion in horizontal direction
	new_deck_button.size_flags_vertical = Control.SIZE_SHRINK_CENTER    # Prevent expansion in vertical direction
	new_deck_button.text = "+"  # Set the text for the button
	deckcontainer.add_child(new_deck_button)  # Add button to the GridContainer
	new_deck_button.pressed.connect(_on_new_deck_pressed)  # Connect the button press to the handler

# Callback when the "New Deck" button is pressed
func _on_new_deck_pressed():
	print("Creating a new deck...")
	# Here you can open a deck creation menu or add a blank deck
