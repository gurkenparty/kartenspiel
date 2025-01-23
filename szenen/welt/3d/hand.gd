extends Node3D  # or Node3D in Godot 4.x

# Reference to the viewport
@export var sprite_viewport: Viewport
@export var spawn_interval: float = 1.0
@export var spawn_area: Vector3 = Vector3(5, 5, 5)

var spawn_timer: float = 0.0

func _ready() -> void:
	# Ensure the ViewportTexture is valid
	if sprite_viewport == null:
		push_error("sprite_viewport is not assigned!")
		return

func _process(delta: float) -> void:
	spawn_timer += delta
	if spawn_timer >= spawn_interval:
		spawn_timer = 0.0
		spawn_sprite()

func spawn_sprite() -> void:
	if sprite_viewport == null:
		return  # Avoid null reference errors

	# Get the ViewportTexture from the Viewport
	var viewport_texture = sprite_viewport.get_texture()

	# Create a new Sprite3D instance
	var sprite = Sprite3D.new()
	sprite.texture = viewport_texture

	# Randomize position within the spawn area
	sprite.translation = Vector3(
		randf_range(-spawn_area.x / 2, spawn_area.x / 2),
		randf_range(-spawn_area.y / 2, spawn_area.y / 2),
		randf_range(-spawn_area.z / 2, spawn_area.z / 2)
	)

	# Add the sprite to the scene
	add_child(sprite)
