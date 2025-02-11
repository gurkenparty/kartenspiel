extends Node3D

@export var grid_size: Vector2 = Vector2(5, 5)  # Grid dimensions
@export var cell_size: float = 2.0  # Size of each cell in world space
@export var card_3d_scene: PackedScene  # Assign your 3D card scene

var grid = {}  # Track occupied cells

func _ready():
	create_grid()

func create_grid():
	for x in range(grid_size.x):
		for z in range(grid_size.y):
			grid[Vector2(x, z)] = null  # Empty grid cells

func is_position_valid(grid_pos: Vector2, size: Vector2):
	for x in range(size.x):
		for z in range(size.y):
			var check_pos = grid_pos + Vector2(x, z)
			if not grid.has(check_pos) or grid[check_pos] != null:
				return false  # Position occupied or out of bounds
	return true

func get_grid_position(screen_position):
	var camera = $Camera3D
	var world_position = camera.project_position(screen_position, 10)  # Depth
	var grid_x = round(world_position.x / cell_size)
	var grid_z = round(world_position.z / cell_size)
	return Vector2(grid_x, grid_z)

func spawn_3d_model(screen_position, card_data):
	var grid_pos = get_grid_position(screen_position)

	if is_position_valid(grid_pos, card_data.model_size):
		var new_card = card_3d_scene.instantiate()
		new_card.transform.origin = Vector3(grid_pos.x * cell_size, 0, grid_pos.y * cell_size)
		new_card.card_data = card_data
		add_child(new_card)
		
		# Mark cells as occupied
		for x in range(card_data.model_size.x):
			for z in range(card_data.model_size.y):
				grid[grid_pos + Vector2(x, z)] = new_card
