@tool
extends Node

@export var title: String = "Titel"
@export var typ: String = "Typ"
@export var story: String = "Story"
@export var effekt: String = "Effekt"
@export var level: int = 1
@export var leben: int = 10
@export var angriff: int = 5
@export var card_layers = []
var card_names = ["Knappe", "Joker"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pick_card_value("Knappe")
	grab_layout(self.typ, self.level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Function to pick a random card name
# Function to pick a card value based on the title
func pick_card_value(Titel: String):
	var statfile = FileAccess.open("res://assets/layouts/values.json", FileAccess.READ)
	if statfile == null:
		push_error("Failed to load JSON file: res://assets/layouts/values.json")
		return
	var json_data = statfile.get_as_text()
	var json = JSON.new()
	var error = json.parse(json_data)
	if error != OK:
		push_error("Failed to parse JSON: %s" % json.get_error_message())
		return
	var stats = json.get_data()
	if stats.has(Titel):
		var stat = stats[Titel]
		self.typ = stat.get("typ", "Default Type")
		self.story = stat.get("story", "Default Story")
		self.effekt = stat.get("effekt", "Default Effekt")
		self.level = stat.get("level", 1)
		self.leben = stat.get("leben", 10)
		self.angriff = stat.get("angriff", 5)
		print_debug(stat.get("title", ""))
		print_debug(self.typ)
		print_debug(self.story)
		print_debug(self.effekt)
		print_debug(self.level)
		print_debug(self.leben)
		print_debug(self.angriff)
	else:
		push_error("Card with title '%s' not found in JSON data." % Titel)

func grab_layout(typ: String, level: int):
	var file = FileAccess.open("res://assets/layouts/overlay.json", FileAccess.READ)
	
	# Check if the file was opened successfully
	if file == null:
		push_error("Failed to load JSON file: res://assets/layouts/overlay.json")
		return []
	
	var json_data = file.get_as_text()
	# Create an instance of the JSON class
	var json = JSON.new()
	# Parse the JSON data
	var error = json.parse(json_data)
	if error != OK:
		push_error("Failed to parse JSON: %s" % json.get_error_message())
		return []
	# The parsed result contains the actual data
	var cards = json.get_data()["gameCards"]
	if cards.is_empty():
		return []

	# Search for the card that matches typ and level
	for card in cards:
		if card.get("typ", "") == typ and card.get("level", -1) == level:
			print_debug(card.get("layers", []))
			self.card_layers = card.get("layers", [])
	
	return []  # Return empty array if no matching card is found
