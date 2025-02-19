extends Node3D  # Or MeshInstance, or any 3D node type for your card

@onready var camera = get_viewport().get_camera()  # Reference to the camera

var is_dragging = false
var mouse_offset = Vector3()  # Offset between mouse position and card position
var board_area = null  # Reference to the GameBoard area for dropping
var dragging = false
var drag_offset = Vector3.ZERO

# Called when the node enters the scene tree
func _ready():
	# Get reference to the game board (could also be done dynamically)
	board_area = get_node("/root/GameBoard")

# Handle input events (mouse interaction)
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				# When the left mouse button is pressed, check if it's on the card
				if is_mouse_over():
					start_drag()
			else:
				if dragging:
					stop_drag()

	if event is InputEventMouseMotion and dragging:
		# While dragging, update the card's position
		var new_position = get_mouse_position_in_world() + drag_offset
		global_transform.origin = new_position  # Move the card in 3D space

# Helper function to check if the mouse is over the card (raycasting from the camera)
func is_mouse_over() -> bool:
	var ray_origin = camera.project_ray_origin(get_viewport().get_mouse_position())
	var ray_direction = camera.project_ray_normal(get_viewport().get_mouse_position())
	
	var intersection = intersect_ray(ray_origin, ray_direction)
	return intersection != Vector3()  # If there is an intersection, return true

# Perform the raycast from the camera to detect the card under the mouse
func intersect_ray(ray_origin: Vector3, ray_direction: Vector3) -> Vector3:
	var space_state = get_world().direct_space_state  # Use get_world() for 3.x or get_world_3d() for 4.x
	var result = space_state.intersect_ray(ray_origin, ray_origin + ray_direction * 1000)  # 1000 is the max ray length
	if result:
		return result.position  # Return the position where the ray hits
	return Vector3()  # Return an empty Vector3 if there's no intersection

# Check if the card is within the bounds of the game board
func is_on_game_board() -> bool:
	var card_position = global_transform.origin
	return board_area.get_rect().has_point(Vector2(card_position.x, card_position.z))  # Example: 2D check

# Start dragging the card
func start_drag():
	dragging = true
	drag_offset = global_transform.origin - get_mouse_position_in_world()

# Stop dragging the card
func stop_drag():
	dragging = false
	if is_on_game_board():
		_drop_on_board()

# Handle logic when the card is dropped on the board
func _drop_on_board():
	print("Card dropped on board!")
	# Implement game logic when the card is dropped (e.g., activating card effect, updating game state, etc.)

# Get the position of the mouse in world coordinates via raycasting
func get_mouse_position_in_world() -> Vector3:
	var mouse_pos = get_viewport().get_mouse_position()
	var origin = camera.project_ray_origin(mouse_pos)
	var direction = camera.project_ray_normal(mouse_pos)
	var length = 1000.0  # Maximum ray length
	var space_state = get_world().direct_space_state  # Use get_world() for 3.x or get_world_3d() for 4.x
	var result = space_state.intersect_ray(origin, origin + direction * length, [self])
	if result.has("position"):
		return result["position"]
	return origin + direction * length
