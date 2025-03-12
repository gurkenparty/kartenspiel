extends Node3D

@export var sprite_texture : Texture2D  # Weisen Sie hier Ihre 2D-Textur zu
@export var card_thickness : float = 0.1  # Dicke der Karte

var card_mesh_instance : MeshInstance3D
var viewport : Viewport

func _ready():
	# Erstellen des Viewports
	viewport = get_viewport()
	viewport.size = Vector2(256, 256)  # Größe des Viewports entsprechend der Textur
	viewport.render_target_update_mode = Viewport.VRS_UPDATE_ALWAYS

	# Erstellen und Hinzufügen des Sprites zum Viewport
	var sprite = Sprite2D.new()
	sprite.texture = sprite_texture
	sprite.position = Vector2(viewport.size.x / 2, viewport.size.y / 2)  # Sprite zentrieren
	viewport.add_child(sprite)

	# Erstellen des Meshes für die Karte
	card_mesh_instance = MeshInstance3D.new()
	card_mesh_instance.mesh = create_card_mesh()

	# Erstellen des Materials und Zuweisen der Viewport-Textur
	var material = StandardMaterial3D.new()
	material.albedo_texture = viewport.get_texture()
	material.local_to_scene = true  # Sicherstellen, dass das Material lokal zur Szene ist

	# Anwenden des Materials auf das Mesh
	card_mesh_instance.material_override = material

	# Hinzufügen des Meshes zur Szene
	add_child(card_mesh_instance)

func create_card_mesh() -> ArrayMesh:
	var mesh = ArrayMesh.new()

	# Erstellen der Vertices für die Vorder- und Rückseite sowie die Seiten
	var vertices = PackedVector3Array([
		Vector3(-0.5, -0.5, -0.5),  # Rückseite unten links
		Vector3( 0.5, -0.5, -0.5),  # Rückseite unten rechts
		Vector3( 0.5,  0.5, -0.5),  # Rückseite oben rechts
		Vector3(-0.5,  0.5, -0.5),  # Rückseite oben links
		Vector3(-0.5, -0.5,  0.5),  # Vorderseite unten links
		Vector3( 0.5, -0.5,  0.5),  # Vorderseite unten rechts
		Vector3( 0.5,  0.5,  0.5),  # Vorderseite oben rechts
		Vector3(-0.5,  0.5,  0.5),  # Vorderseite oben links
	])

	# Erstellen der Indizes für die Dreiecke der Karte
	var indices = PackedInt32Array([
		0, 1, 2, 0, 2, 3,  # Rückseite
		4, 5, 6, 4, 6, 7,  # Vorderseite
		0, 1, 5, 0, 5, 4,  # Unterseite
		2, 3, 7, 2, 7, 6,  # Oberseite
		0, 3, 7, 0, 7, 4,  # Linke Seite
		1, 2, 6, 1, 6, 5,  # Rechte Seite
	])

	# Erstellen der UV-Koordinaten für die Textur
	var uvs = PackedVector2Array([
		Vector2(0.0, 0.0),  # Rückseite unten links
		Vector2(1.0, 0.0),  # Rückseite unten rechts
		Vector2(1.0, 1.0),  # Rückseite oben rechts
		Vector2(0.0, 1.0),  # Rückseite oben links
		Vector2(0.0, 0.0),  # Vorderseite unten links
		Vector2(1.0, 0.0),  # Vorderseite unten rechts
		Vector2(1.0, 1.0),  # Vorderseite oben rechts
		Vector2(0.0, 1.0),  # Vorderseite oben links
	])

	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_TEX_UV] = uvs
	arrays[Mesh.ARRAY_INDEX] = indices

	# Erstellen der Oberflächen für das Mesh
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)

	return mesh
