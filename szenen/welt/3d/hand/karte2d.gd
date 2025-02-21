extends Button

signal card_placed(card)  # Declare the signal

@export var cardimg: Texture2D
@export var draggable: PackedScene
@export var cam: Camera3D
var is_dragging = false
var local_draggable: Node
var placed = false

func _ready() -> void:
	icon = cardimg
	local_draggable = draggable.instantiate()
	add_child(local_draggable)

	# This ensures Karte3D knows which Karte2D it belongs to
	local_draggable.set_karte2d(self)

	local_draggable.visible = false
	cam = get_viewport().get_camera_3d()

func _physics_process(_delta):
	var rayResult: Dictionary = {}

	if is_dragging and not placed:
		var space_state = local_draggable.get_world_3d().direct_space_state
		var mouse_pos: Vector2 = get_viewport().get_mouse_position()
		var origin: Vector3 = cam.project_ray_origin(mouse_pos)
		var direction: Vector3 = cam.project_ray_normal(mouse_pos)
		var end: Vector3 = origin + direction * 1000

		var query = PhysicsRayQueryParameters3D.create(origin, end)
		query.collide_with_areas = true
		rayResult = space_state.intersect_ray(query)

		if rayResult.has("collider") and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			var co: CollisionObject3D = rayResult.get("collider")
			local_draggable.global_position = Vector3(cam.global_position.x, cam.global_position.y - 1, cam.global_position.z)
			local_draggable.visible = true
			var hand_tween = create_tween()
			hand_tween.tween_property(local_draggable, "position", Vector3(co.global_position.x, 2.0, co.global_position.z), 0.2)
			self.visible = false
			placed = false

	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and is_dragging:
		if rayResult.has("collider"):
			var co: CollisionObject3D = rayResult.get("collider")
			var card_key = cardimg.resource_path

			var x_position = GameState.field_start_x
			var y_position = 0.1
			var z_position = GameState.field_z

			if GameState.placed_cards.has(card_key):
				var stack_count = GameState.placed_cards[card_key].size()
				x_position = GameState.placed_cards[card_key][0].x + (stack_count * 0.2)
				y_position = 0.1
			else:
				x_position += GameState.field_spacing * GameState.placed_cards.size()

			var final_position = Vector3(x_position, y_position, z_position)

			var placing_tween = create_tween()
			placing_tween.tween_property(local_draggable, "position", final_position, 0.2)

			if not GameState.placed_cards.has(card_key):
				GameState.placed_cards[card_key] = []
			GameState.placed_cards[card_key].append(final_position)

			placed = true
			is_dragging = false
			local_draggable.visible = true
			self.visible = false
			local_draggable.played = true
			local_draggable.add_to_group("Player1")
			# Emit the signal to notify the hand container
			card_placed.emit(self)
			print("Card " + str(self) + " emitted")
		else:
			placed = false
			var hand_tween = create_tween()
			hand_tween.tween_property(local_draggable, "position", Vector3(cam.global_position.x, cam.global_position.y - 1, cam.global_position.z), 0.2)
			local_draggable.visible = false
			self.visible = true
			is_dragging = false

	if not is_dragging and placed:
		local_draggable.visible = true
		self.visible = false

func _on_button_down() -> void:
	is_dragging = true
	print("Button Down")

func _on_button_up() -> void:
	is_dragging = false
	print("Button Up")
