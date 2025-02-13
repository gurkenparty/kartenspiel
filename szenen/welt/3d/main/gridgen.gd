@tool
extends Node3D

@export var grid_width: int = 5
@export var grid_depth: int = 5
@export var cell_size: float = 2.0  # Adjust based on cell dimensions
@export var cell_scene: PackedScene
const HOVER_COLOR = Color(0, 1, 0, 1)  # Green
const DEFAULT_COLOR = Color(1, 1, 1, 1)  # White
const RADIUS = 5.0  # Adjust radius for effect

var hovered_tiles := []

@export var camera: Camera3D
@export var cursor_marker: Node3D  # Assign this in the Inspector (a small invisible object)

func _ready():
	cursor_marker.add_to_group("cursor")
	generate_grid()

func generate_grid():
	# Remove existing cells before regenerating
	for child in get_children():
		if child is Node3D and child != camera and child != cursor_marker:
			child.queue_free()
	
	# Generate new grid
	for x in range(grid_width):
		for z in range(grid_depth):
			var cell = cell_scene.instantiate()
			cell.transform.origin = Vector3(x * cell_size, 0, z * cell_size)
			add_child(cell)
			cell.add_to_group("tiles")  # Add the tile to the "tiles" group

func _process(delta):
	update_cursor_position()

	# Find all tiles under the cursor (use Area3D for detection)
	var hovered_tiles = get_hovered_tiles()
	highlight_tiles(hovered_tiles)

func get_hovered_tiles() -> Array:
	var tiles_in_range = []
	var cursor_pos = cursor_marker.global_transform.origin
	
	# Convert RADIUS to a grid-aligned square selection
	var half_size = ceil(RADIUS / cell_size)  # Ensure at least 1 tile is selected

	# Iterate over all tiles
	for tile in get_tree().get_nodes_in_group("tiles"):
		var tile_pos = tile.global_transform.origin

		# Check if the tile is within the square bounds around the cursor
		if (
			abs(tile_pos.x - cursor_pos.x) < half_size * cell_size and
			abs(tile_pos.z - cursor_pos.z) < half_size * cell_size
		):
			tiles_in_range.append(tile)

	return tiles_in_range


func update_cursor_position():
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_direction = camera.project_ray_normal(mouse_pos)

	# Calculate intersection with Y = 0.1 plane
	var t = (0.1 - ray_origin.y) / ray_direction.y  # Solve for Y = 0.1
	var world_position = ray_origin + ray_direction * t

	# Set the cursor's position
	cursor_marker.global_transform.origin = Vector3(world_position.x, 0.1, world_position.z)
	print("Cursor Position:", cursor_marker.global_transform.origin)

func highlight_tiles(tiles):
	reset_highlighted_tiles()
	hovered_tiles = tiles
	for tile in hovered_tiles:
		if tile.has_method("set_color"):
			tile.set_color(true)

func reset_highlighted_tiles():
	for tile in hovered_tiles:
		if tile.has_method("set_color"):
			tile.set_color(false)
	hovered_tiles.clear()
