extends Node3D
func _physics_process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		# Get the physics space state
		var space_state = get_world_3d().direct_space_state

		# Get the mouse position in the viewport
		var mouse_pos = get_viewport().get_mouse_position()

		# Get camera node (make sure the path is correct)
		var camera = $Camera3D  

		# Compute ray origin and direction
		var origin = camera.project_ray_origin(mouse_pos)
		var end = origin + camera.project_ray_normal(mouse_pos) * 1000  # Ray length

		# Create raycast query
		var query = PhysicsRayQueryParameters3D.create(origin, end)
		query.collide_with_areas = true  # Include areas in collision detection

		# Perform the raycast
		var rayResult: Dictionary = space_state.intersect_ray(query)

		# Check if the ray hit something
		if rayResult.size() > 0:

			# Get the collided object
			var co: CollisionObject3D = rayResult.get("collider")
