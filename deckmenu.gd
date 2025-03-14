extends Control


@export var deck_preview_scene: PackedScene = load("res://szenen/element_preview.tscn")  # Scene for deck preview
@export var columns: int = 2  # Number of columns in the grid (adjust as needed)
@export var input_panel:Panel
@export var cardmenu_scene:PackedScene = load("res://szenen/cardmenu.tscn")
var deck = [
	"Knappe", "Landwirtin",
	"Joker", "Ritter", "Assasine", "Grundbesitzerin",
	"Graf_Zacharias", "Gerd", "Urus", "Bär",
	"Gift", "Späher", "Muti", "Stratege", "Meister",
	"Unge", "Hauer", "Zerfleischer", "EF", "RO", "Kirill", "Blumen", "Erde", 
	"Feuer", "Glas" , "Licht", "Natur", "Schatten", "Stahl", "Wasser", "Xera", "TW", "BB", "EK", "Vet", "Sch"
]
var blacklist = []
var deck_preview:Texture2D = load("res://assets/wallpapers/Wallpaper_Schmied.png")
var z_spawn:int = 72
var default_x:int = 55
var nametext_line:LineEdit
func _ready() -> void:
	print_debug("Decks: " + str(GameStats.decks))
	refresh_deck_display()
	nametext_line = input_panel.get_child(0)

# Function to refresh the deck display in the menu
func refresh_deck_display():
	# Clear all existing UI elements
	for child in self.get_children():
		if child.name != "Panel":
			child.queue_free()
			

	# Set the number of columns for the GridContainer
	var new_deck_button_scene = deck_preview_scene.instantiate()
	new_deck_button_scene.global_position = Vector2(default_x, z_spawn)
	new_deck_button_scene.change_deck_name("New Deck")
	new_deck_button_scene.element_pressed.connect(_on_element_pressed)
	add_child(new_deck_button_scene)
	# Iterate over each deck in GameStats.decks and create a UI for it
	for deck in GameStats.decks:
		var deck_preview_scene_instance = deck_preview_scene.instantiate()
		print_debug(deck.deck_name)
		print_debug(str(deck.preview))
		deck_preview_scene_instance.change_deck_name(deck.deck_name)
		deck_preview_scene_instance.change_preview(deck.preview)
		deck_preview_scene_instance.deck = deck
		deck_preview_scene_instance.element_pressed.connect(_on_element_pressed)
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


func _on_element_pressed(element:Button):
	print_debug("element.name is: " + str(element.deck_name))
	if element.deck_name == "New Deck":
		print_debug("in visible deck loop")
		input_panel.visible = true
	else:
		print_debug("in else scene")
		var cardmenu_scene_instance = cardmenu_scene.instantiate()
		print_debug("Deck Cards: " + str(element.deck.cards))
		cardmenu_scene_instance.cards = element.deck.cards
		cardmenu_scene_instance.deck_name = element.deck.deck_name
		cardmenu_scene_instance.deck = element.deck
		cardmenu_scene_instance.closing_editor.connect(_on_editor_closed)
		add_child(cardmenu_scene_instance)
		for child in self.get_children():
			if child.name != "Panel" and child.name != cardmenu_scene_instance.name:
				child.queue_free()



func _on_nameset_pressed() -> void:
	input_panel.visible = false
	print("nameset pressed")
	print_debug(nametext_line.text)
	if nametext_line.text != "":
		for deck in GameStats.decks:
			if deck.deck_name == nametext_line.text:
				return
		Deck.new(nametext_line.text, deck_preview, deck)
		refresh_deck_display()

func _on_editor_closed():
	refresh_deck_display()
	self.visible = true
