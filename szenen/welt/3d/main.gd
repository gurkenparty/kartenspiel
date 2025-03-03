extends Node3D

@export var camera_1: Camera3D  # Assign Player 1's Camera in the editor
@export var camera_2: Camera3D  # Assign Player 2's Camera in the editor

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):  # Press "Enter" to switch cameras
		if camera_1.current:
			camera_1.current = !camera_1.current
			camera_2.current = camera_2.current
		elif camera_2.current:
			camera_1.current = camera_1.current
			camera_2.current = !camera_2.current
		print("Switched Camera! Now using:", "Camera1" if camera_1.current else "Camera2")

func _physics_process(delta):
	# Ensure this only runs on the local player’s device
	if not is_local_player():
		return

	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var space_state = get_world_3d().direct_space_state
		var mouse_pos = get_viewport().get_mouse_position()
		
		# Get the correct camera for this player
		var camera = get_local_camera()
		
		# Compute ray origin and direction
		var origin = camera.project_ray_origin(mouse_pos)
		var end = origin + camera.project_ray_normal(mouse_pos) * 1000  # Ray length
		
		# Create raycast query
		var query = PhysicsRayQueryParameters3D.create(origin, end)
		query.collide_with_areas = true  # Include areas in collision detection
		
		# Perform the raycast
		var rayResult: Dictionary = space_state.intersect_ray(query)
		
		if rayResult.size() > 0:
			var co: CollisionObject3D = rayResult.get("collider")
			print("Hit: ", co.name)

			# If needed, send the interaction to other players
			rpc("notify_click", co.name)

@rpc("any_peer", "call_local")
func notify_click(object_name: String):
	print("Object clicked by another player:", object_name)

func is_local_player() -> bool:
	return multiplayer.get_unique_id() == get_local_player_id()

func get_local_camera() -> Camera3D:
	if get_local_player_id() == 1:
		return camera_1
	else:
		return camera_2

func get_local_player_id() -> int:
	return 1 if multiplayer.get_unique_id() == 1 else 2
