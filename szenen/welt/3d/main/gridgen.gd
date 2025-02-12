@tool
extends Node3D

@export var grid_width: int = 5
@export var grid_depth: int = 5
@export var cell_size: float = 2.0  # Adjust based on cell dimensions
@export var cell_scene: PackedScene
const HOVER_COLOR := Color(0, 1, 0, 1)  # Green
const DEFAULT_COLOR := Color(1, 1, 1, 1)  # White
const RADIUS := 2.0  # Adjust radius for effect

var hovered_tiles := []
@onready var ray := $Camera3D/RayCast3D


@onready var camera := $Camera3D

func _ready():
	generate_grid()

func generate_grid():
	# Remove existing cells before regenerating
# Remove existing cells before regenerating, but don't remove the camera
	for child in get_children():
		if child is Node3D and child != camera and child != ray:
			child.queue_free()

	
	# Generate new grid
	for x in range(grid_width):
		for z in range(grid_depth):
			var cell = cell_scene.instantiate()
			cell.transform.origin = Vector3(x * cell_size, 0, z * cell_size)
			add_child(cell)
			cell.add_to_group("tiles")  # Add the tile to the "tiles" group
			
			


func _process(delta):
	update_hovered_tiles()
	
func update_hovered_tiles():
	print("update_hovered_tiles is called")

	var ray_target = get_mouse_target_position()  # Get the ray's target position
	ray.target_position = ray_target  # Set the target position directly
	ray.force_raycast_update()
	if ray.is_colliding():
		var tile = ray.get_collider()
		print("Ray is colliding with: " + str(tile))  # Add more detail to the log
		if tile and tile.is_in_group("tiles"):  # Check if the tile is in the "tiles" group
			print("Tile is in the 'tiles' group!")
			highlight_tiles(get_nearby_tiles(tile))
		else:
			print("Tile is NOT in the 'tiles' group!")
	else:
		print("Ray is not colliding with anything.")
		reset_highlighted_tiles()
		print("Tiles resetted")

func get_mouse_target_position() -> Vector3:
	var mouse_pos = get_viewport().get_mouse_position()
	
	# Getting the ray from the camera to the 3D world based on the mouse position
	var ray_origin = camera.position  # Ray starts from the camera position
	var ray_direction = camera.project_ray_normal(mouse_pos)
	ray_direction.y = -1  # Pointing down (negative Y direction)  # Ray direction from camera to mouse in 3D world
	
	# Debug prints to check the values
	print("Camera Position: ", camera.position)
	print("Mouse Position: ", mouse_pos)
	print("Ray Origin: ", ray_origin)
	print("Ray Direction Before Y Constraint: ", ray_direction)
	
	# Optionally, limit the height range to avoid pointing too high or too low

	print("Ray Direction After Y Constraint: ", ray_direction)

	# Compute the ray target position by adding the direction multiplied by a distance (10 units away)
	return ray_origin + ray_direction * 10  # Adjust multiplier as needed for your scene scale

func get_nearby_tiles(center_tile) -> Array:
	var nearby_tiles = []
	for tile in get_tree().get_nodes_in_group("tiles"):
		if tile.global_transform.origin.distance_to(center_tile.global_transform.origin) <= RADIUS:
			nearby_tiles.append(tile)
	return nearby_tiles

func highlight_tiles(tiles):
	reset_highlighted_tiles()
	hovered_tiles = tiles
	for tile in hovered_tiles:
		if tile.has_method("set_color"):
			tile.set_color(HOVER_COLOR)

func reset_highlighted_tiles():
	for tile in hovered_tiles:
		if tile.has_method("set_color"):
			tile.set_color(DEFAULT_COLOR)
	hovered_tiles.clear()
