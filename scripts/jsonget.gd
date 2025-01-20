extends Node

@export var cards_json_path = "res://json/cards.json"  # Path to your cards JSON file
@export var values_json_path = "res://json/value.json"  # Path to your values JSON file

func _ready():
	var cards_data = load_json(cards_json_path)
	var values_data = load_json(values_json_path)
	
	if cards_data and values_data:
		for value_info in values_data:
			var layout = find_layout_by_id(cards_data, value_info["layout_id"])
			if layout:
				create_card(layout, value_info)
			else:
				print("No layout found for layout_id:", value_info["layout_id"])

# Function to load and parse JSON data
func load_json(path):
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		var json_text = file.get_as_text()
		var json_result = JSON.parse_string(json_text)
		if typeof(json_result) == TYPE_ARRAY:
			return json_result
		else:
			print("Error parsing JSON data from:", path)
		file.close()
	else:
		print("Failed to open JSON file:", path)
	return null

# Function to find layout by layout_id
func find_layout_by_id(cards_data, layout_id):
	for layout in cards_data:
		if layout.get("layout_id") == layout_id:
			return layout
	return null

# Function to create a card based on layout and value information
func create_card(layout, value_info):
	var card_node = Node2D.new()
	add_child(card_node)
	
	for layer_path in layout["layers"]:
		var sprite = Sprite2D.new()
		card_node.add_child(sprite)
		
		if layer_path == "Character":
			var character_image_path = "res://Assets/Cards/Img/%s.png" % value_info["name"]
			sprite.texture = load_texture(character_image_path)
		else:
			sprite.texture = load_texture(layer_path)
		
		if not sprite.texture:
			print("Failed to load texture for layer:", layer_path)
	
	# Additional properties
	card_node.name = value_info["name"]


# Function to load a texture from a given path
func load_texture(path):
	var texture = load(path)
	if texture:
		return texture
	else:
		print("Error loading texture from path:", path)
		return null
