extends Node3D

@export var default_material : Material
@export var hover_material : Material
@onready var area = $Area3D  # Assuming Area3D is a direct child

var current_material : Material

func _ready():
	# Set the default material
	current_material = default_material
	$Area3D/Feld.material_override = default_material  # Assuming the mesh is a MeshInstance3D

	# Connect signals for the Area3D
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)

# Change material based on the highlight state
func set_color(is_highlighted: bool):
	if is_highlighted:
		$Area3D/Feld.material_override = hover_material
	else:
		$Area3D/Feld.material_override = default_material


func _on_body_entered(body: Node3D) -> void:
		if body.is_in_group("cursor"):  # You can add a group for your cursor object
			print("Mouse entered tile")
			set_color(true)


func _on_body_exited(body: Node3D) -> void:
		if body.is_in_group("cursor"):  # You can add a group for your cursor object
			print("Mouse exited tile")
			set_color(false)
