extends Node3D

@export var raycast: RayCast3D  # RayCast3D node for detecting objects
@export var grabPos: Node3D     # Position where the grabbed object should be placed
var picked = null               # The object that is currently grabbed

func _ready() -> void:
	grabPos.visible = false     # Make the grab position invisible initially
	grabPos.disabled = true     # Disable the grab position initially

func _physics_process(delta: float) -> void:
	# Check if the player presses the interact button to grab an object
	if Input.is_action_just_pressed("Interact"):
		can_grab()

	# Check if the player presses the drop button to release the object
	if Input.is_action_just_pressed("DropObj"):
		if picked:
			release_object()

# Function to grab an object
func can_grab():
	if raycast.is_colliding():  # If the raycast is hitting something
		picked = raycast.get_collider()  # Get the collider the raycast is hitting
		if picked:
			print("Object grabbed: " + str(picked.name))
			grabPos.position = picked.position  # Move the grab position to the object
			grabPos.visible = true  # Make the grab position visible

# Function to release the object
func release_object():
	if picked:
		print("Object released: " + str(picked.name))
		picked = null  # Reset the picked object
		grabPos.visible = false  # Hide the grab position
