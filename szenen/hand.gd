extends Node3D

@export var card_scene: PackedScene  # The card scene to spawn
@export var camera: Camera3D  # Reference to the 3D camera

var hand_cards = []  # Stores spawned cards
var hovered_card = null  # Only one card can be hovered at a time

const CARD_SPACING = 1.5  # Adjust spacing between cards
const HOVER_OFFSET = Vector3(0, 0.5, 0)  # Move up on hover
const HOVER_SCALE = Vector3(1.2, 1.2, 1.2)  # Scale on hover
const FAN_ANGLE = 30  # Angle of the fan spread (degrees)

# Adjust card properties
const CARD_SIZE = Vector3(1, 1, 1)  # Size of the cards (change these values based on your card model)

func _ready():
	spawn_hand_cards()

func spawn_hand_cards():
	var start_pos = Vector3(0, -1, -3)  # Closer to the camera and lower (adjust height to fit the view)
	var angle_step = FAN_ANGLE / (6 - 1)  # Calculate the angle step to spread the cards

	for i in range(6):
		var card = card_scene.instantiate()
		
		# Apply card size (scale down to a realistic size)
		card.scale = CARD_SIZE
		
		# Calculate angle for the current card
		var angle = -FAN_ANGLE / 2 + i * angle_step
		var card_position = start_pos + Vector3(CARD_SPACING * i, 0, 0)
		
		# Apply a slight fan effect based on the angle (rotate on the Y-axis)
		card_position = card_position.rotated(Vector3(0, 1, 0), deg_to_rad(angle))
		
		# Set the position of the card
		card.transform.origin = card_position  # Set position
		card.original_position = card_position  # Store original position
		card.original_scale = card.scale  # Store original scale
		
		# Make sure the card faces towards the camera
		face_camera(card)

		# Connect hover signals
		card.connect("mouse_entered", _on_card_hover.bind(card))
		card.connect("mouse_exited", _on_card_exit.bind(card))
		
		# Add to the scene and the hand_cards list
		add_child(card)
		hand_cards.append(card)

# Make card face the camera (ensures proper rotation without distortion)
func face_camera(card):
	# Step 1: Get the direction vector from the card to the camera
	var direction = (camera.global_transform.origin - card.global_transform.origin).normalized()

	# Step 2: Rotate the card to face the camera horizontally (along the Y-axis)
	card.look_at(camera.global_transform.origin, Vector3(0, 1, 0))
	
	# Step 3: Adjust the card's X-axis based on the camera's vertical tilt (pitch)
	
	# Convert the camera's pitch from radians to degrees
	var camera_pitch_degrees = rad_to_deg(camera.rotation.x)
	
	# Apply the camera's pitch (tilt) to the card's X-axis rotation
	card.rotation_degrees.x = camera_pitch_degrees
	
	# Optional: Debugging output to see what’s going on
	print_debug("Camera Pitch (radians):", camera.rotation.x)
	print_debug("Camera Pitch (degrees):", camera_pitch_degrees)
	print_debug("Card Rotation X:", card.rotation_degrees.x)

func _on_card_hover(card):
	if hovered_card == null:  # Only allow one hover at a time
		hovered_card = card
		var tween = get_tree().create_tween()
		tween.tween_property(card, "transform:origin", card.original_position + HOVER_OFFSET, 0.2)
		tween.tween_property(card, "scale", HOVER_SCALE, 0.2)

# Reset hover effect when exiting
func _on_card_exit(card):
	if hovered_card == card:  # Reset only the hovered card
		hovered_card = null
		var tween = get_tree().create_tween()
		tween.tween_property(card, "transform:origin", card.original_position, 0.2)
		tween.tween_property(card, "scale", card.original_scale, 0.2)
