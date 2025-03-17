extends Node3D
signal cards_drawed
var music_player: AudioStreamPlayer
@export var camera3d: Camera3D
@export var target_z: float = -62.046  # Final target on the Z-axis
@export var transition_z: float = 42.0  # Point where Y movement starts
@export var target_y: float = 4.6  # Target Y position
@export var duration_z: float = 7.0  # Time to reach target_z
@export var duration_y: float = 3.0  # Time to move up on Y-axis
@export var weiter_btn: Button
@export var card_vis_sprite: Sprite3D
@export var background_music: AudioStream
var card_sprites: Array[Texture2D] = []
var card_names: Array = []
var cards_to_draw = [1,1,1,1,2,2,2,2,3,3,1,1,1,1,2,2,2,2,3,3,1,1,1,1,2,2,2,2,3,3,1,1,1,1,2,2,2,2,3,3,4,4,5]  # Possible draws
var list_index = 0

var elapsed_time_z: float = 0.0  # Time tracker for Z movement
var elapsed_time_y: float = 0.0  # Time tracker for Y movement
var start_z: float
var start_y: float
var moving_y: bool = false  # Start Y movement only at Z = -42

var cards_to_draw_int: int = 0

func _ready() -> void:
	# Select a random number of cards to draw
	cards_to_draw_int = cards_to_draw.pick_random()
	music_player = AudioStreamPlayer.new()
	add_child(music_player)  # Add it to the scene

	# Set the background music to the player
	music_player.stream = background_music

	# Set looping to true in the AudioStream resource
	if music_player.stream != null:
		music_player.stream.loop = true

	# Play the music
	music_player.play()
	# Ensure the global card library is available
	if not GlobalLibrary.cards.is_empty():
		for i in range(cards_to_draw_int):
			var card_key = GlobalLibrary.cards.keys()[randi() % GlobalLibrary.cards.size()]  # Pick a random key
			var card_data = GlobalLibrary.cards[card_key]  # Get card data dictionary

			card_sprites.append(card_data["texture"])
			card_names.append(card_key)

		# Set initial card texture
		if card_sprites.size() > 0:
			card_vis_sprite.texture = card_sprites[list_index]
			list_index += 1

	# Store initial camera positions
	if camera3d:
		start_z = camera3d.position.z
		start_y = camera3d.position.y

	weiter_btn.disabled = true

func _process(delta: float) -> void:
		# Move along Z-axis
		if camera3d.position.z > target_z:
			elapsed_time_z += delta
			var t_z = clamp(elapsed_time_z / duration_z, 0.0, 1.0)
			t_z = t_z * t_z * (3.0 - 2.0 * t_z)  # Smoothstep function

			camera3d.position.z = lerp(start_z, target_z, t_z)

			# Start moving up on Y once Z reaches transition point
			if camera3d.position.z <= transition_z and not moving_y:
				moving_y = true
				start_y = camera3d.position.y

		# Move along Y-axis after reaching transition point
		if moving_y and camera3d.position.y < target_y:
			elapsed_time_y += delta
			var t_y = clamp(elapsed_time_y / duration_y, 0.0, 1.0)
			t_y = t_y * t_y * (3.0 - 2.0 * t_y)  # Smoothstep function

			camera3d.position.y = lerp(start_y, target_y, t_y)
		else:
			weiter_btn.disabled = false

func _on_button_pressed() -> void:
	if list_index < card_sprites.size():
		card_vis_sprite.texture = card_sprites[list_index]
		list_index += 1
	else:
		GameStats.user_cards.append_array(card_names)
		get_tree().change_scene_to_file("res://szenen/hub.tscn")
	
