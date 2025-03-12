extends Node  # Or Sprite3D, Control, MeshInstance, depending on your specific use

var is_dragging = false
var mouse_offset = Vector3()  # Offset between mouse position and card position
var board_area = null  # Reference to the GameBoard area for dropping

func _ready():
	# Get reference to the game board (could also be done dynamically)
	board_area = get_node("/root/GameBoard")
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				# When the left mouse button is pressed, check if it's on the card
				if is_mouse_over_card():
					is_dragging = true
					# Calculate the offset to keep the card in a consistent position
					mouse_offset = global_transform.origin - get_global_mouse_position()
			else:
				if is_dragging:
					is_dragging = false
					if is_on_game_board():
						_drop_on_board()
						
	if event is InputEventMouseMotion and is_dragging:
		# While dragging, update the card's position
		var new_position = get_global_mouse_position() + mouse_offset
		global_transform.origin = new_position  # Move the card in 3D space

# Check if the mouse is over the card (you can use the bounding box of the card here)
func is_mouse_over_card() -> bool:
	var ray_origin = get_viewport().get_camera().project_ray_origin(get_viewport().get_mouse_position())
	var ray_direction = get_viewport().get_camera().project_ray_normal(get_viewport().get_mouse_position())
	
	var intersection = ray_intersects(ray_origin, ray_direction)
	return intersection != null

# Check if the card is within the bounds of the game board
func is_on_game_board() -> bool:
	var card_position = global_transform.origin
	return board_area.get_rect().has_point(Vector2(card_position.x, card_position.z))  # Example, check if it's inside the board area

func _drop_on_board():
	print_debug("Card dropped on board!")
	# Handle logic for card placement on the board (e.g., adding it to a list, activating card effect)
	# You can reset the card position, update the game state, etc.
