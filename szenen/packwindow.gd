extends Node2D

@export var packwalk:PackedScene = load("res://szenen/packwalk.tscn")
var packwalk_instance
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pack_pressed() -> void:
	get_tree().change_scene_to_file("res://szenen/packwalk.tscn")
	
