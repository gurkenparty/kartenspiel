extends Area3D

@onready var mesh_instance := $Feld
func set_color(color: Color):
	var mat = mesh_instance.get_surface_override_material(0)
	if mat:
		print("Material found: ", mat)
		mat.albedo_color = color
	else:
		print("No material override found, creating new material")
		var new_mat = StandardMaterial3D.new()
		new_mat.albedo_color = color
		mesh_instance.set_surface_override_material(0, new_mat)
