extends SubViewportContainer

@export var target_resolution : Vector2 = Vector2(DisplayServer.screen_get_size())
@export var game_scene: PackedScene = load("res://szenen/game_3d.tscn")
@export var scene:Node3D
var sub_viewport:SubViewport
var game_scene_instance
func _ready():

	stretch = true  # Enable stretching
	stretch_shrink = 1  # Optional: Adjust as needed
	self.visible = false

func _on_spielen_pressed() -> void:
	game_scene_instance = game_scene.instantiate()
	sub_viewport.add_child(game_scene_instance)
	self.visible = true
	game_scene_instance.visible = true
	print_debug("Game started Visibility of scene is: " +str(game_scene_instance.name) + str(game_scene_instance.visible))
