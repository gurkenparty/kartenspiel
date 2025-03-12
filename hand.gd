extends Node3D

@export var raycast: RayCast3D  # Export the RayCast3D node to be assigned in the editor
@export var camera: Camera3D  # Camera3D reference to be assigned in the editor
@export var card_scene: PackedScene  # Reference to the card scene

var cards_in_hand = []  # List to store the card instances
var selected_card : Node3D = null  # The currently selected card for dragging
var is_dragging = false  # Flag to check if dragging is happening

func _ready():
	# Ensure the RayCast3D is enabled
	if raycast:
		raycast.enabled = true  # Make sure it's active in the scene

	_spawn_hand()

# Spawning cards in hand
func _spawn_hand():
	for i in range(5):  # Add 5 cards to the hand
		var card_instance = card_scene.instantiate()
		
		# Position the card in 3D space
		var card_position = Vector3(i * 0.5, camera.position.y - 2, camera.position.z)
		card_instance.position = card_position
		card_instance.rotation_degrees = Vector3(camera.rotation_degrees.x, 0, 0)
		
		# Add collision shape to each card
		var collision = CollisionShape3D.new()
		collision.shape = BoxShape3D.new()  # Shape to match card's geometry
		card_instance.add_child(collision)
		
		add_child(card_instance)
		cards_in_hand.append(card_instance)

		# Debugging: output card creation info
		print_debug("Card spawned: ", card_instance.name)

# Check for mouse input continuously
func _process(delta):
	if Input.is_action_just_pressed("click"):  # Mouse click down
		print_debug("Mouse button pressed")
		_handle_mouse_click()

	if is_dragging and selected_card:
		_handle_card_drag()

	if Input.is_action_just_released("click"):  # Mouse button released
		_handle_mouse_release()

# Handling mouse click to detect selection
func _handle_mouse_click():
	# Project the mouse position into 3D space
	var mouse_position = get_viewport().get_mouse_position()
	print_debug("Mouse position: ", mouse_position)
	
	var from = camera.position
	var direction = camera.project_ray_normal(mouse_position)
	var to = from + direction * 1000  # Extend the ray far into the world

	# Debugging: ray info
	print_debug("Raycast origin: ", from)
	print_debug("Raycast target: ", to)
	
	# Update the RayCast3D's origin and direction
	raycast.cast_from = from
	raycast.cast_to = to
	
	# Check if the raycast collides with anything
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		print_debug("Raycast collided with: ", collider)

		# Check if the raycast collided with any card
		for card in cards_in_hand:
			if collider == card:
				selected_card = card
				is_dragging = true
				print_debug("Card selected: ", card.name)
				break

# Handling card drag
func _handle_card_drag():
	if selected_card:
		var mouse_position = get_viewport().get_mouse_position()
		var from = camera.position
		var direction = camera.project_ray_normal(mouse_position)
		var to = from + direction * 1000  # Extend the ray

		# Update the RayCast3D's position by setting the transform
		raycast.cast_from = from
		raycast.cast_to = to
		
		# Move the card to the raycast's collision point
		if raycast.is_colliding():
			selected_card.position = raycast.get_collision_point()
			print_debug("Card dragged to: ", selected_card.position)

# Handling mouse release (end drag)
func _handle_mouse_release():
	if selected_card:
		is_dragging = false
		selected_card = null
		print_debug("Drag ended.")
