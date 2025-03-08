extends Control

var game3d_scene: PackedScene = preload("res://szenen/game_3d.tscn")
var show_scene: PackedScene = preload("res://szenen/showroom.tscn")
var music_player: AudioStreamPlayer

# A reference to your background music
@export var background_music: AudioStream

@onready var showroom_scene: SubViewportContainer = $Showroom
@export var showroom_subviewport: SubViewport
@export var game_subviewport: SubViewport
var showroom_scene_instance: Node
var game_scene_instance: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Create the AudioStreamPlayer node if not already created
	music_player = AudioStreamPlayer.new()
	add_child(music_player)  # Add it to the scene

	# Set the background music to the player
	music_player.stream = background_music

	# Set looping to true in the AudioStream resource
	if music_player.stream != null:
		music_player.stream.loop = true

	# Play the music
	music_player.play()


# Button pressed to start the game
func _on_spielen_pressed() -> void:
	# Transition to a loading scene (you can load your loading screen here)
	get_tree().change_scene_to_file("res://szenen/scene_load.tscn")
