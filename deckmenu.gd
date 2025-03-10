extends Control

@export var deckcontainer: GridContainer  # GridContainer for layout
@export var deck_preview_scene: PackedScene = load("res://szenen/element_preview.tscn")  # Scene for deck preview
@export var columns: int = 2  # Number of columns in the grid (adjust as needed)
var deck_preview:Texture2D = load("res://assets/wallpapers/Wallpaper_Schmied.png")
var z_spawn:int = 72
var default_x:int = 55
func _ready() -> void:
	print("Decks: " + str(GameStats.decks))
	refresh_deck_display()

# Function to refresh the deck display in the menu
func refresh_deck_display():
	# Clear all existing UI elements
	for child in self.get_children():
			child.queue_free()
			

	# Set the number of columns for the GridContainer
	var new_deck_button_scene = deck_preview_scene.instantiate()
	new_deck_button_scene.global_position = Vector2(default_x, z_spawn)
	new_deck_button_scene.change_deck_name("New Deck")
	add_child(new_deck_button_scene)
	# Iterate over each deck in GameStats.decks and create a UI for it
	for deck in GameStats.decks:
		var deck_preview_scene_instance = deck_preview_scene.instantiate()
		print(deck.deck_name)
		print(str(deck.preview))
		deck_preview_scene_instance.change_deck_name(deck.deck_name)
		deck_preview_scene_instance.change_preview(deck.preview)
		add_child(deck_preview_scene_instance)
		deck_preview_scene_instance.global_position = new_deck_button_scene.global_position
		#299
		var moving_distance = 260
		if new_deck_button_scene.global_position.x + moving_distance > 1688:
			new_deck_button_scene.global_position.y += 299
			new_deck_button_scene.global_position.x = default_x
		else:
			new_deck_button_scene.global_position.x += moving_distance

# Callback when the "New Deck" button is pressed



func _on_new_deck_button_pressed() -> void:
	print("Creating a new deck...")
