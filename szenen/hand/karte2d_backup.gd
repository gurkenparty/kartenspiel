extends Button

signal card_placed(card, card3d)  # Declare the signal
@export var cardimg: Texture2D
@export var draggable: PackedScene
@export var cam: Camera3D
@export var option_btn: Button
@export var weiter_btn: Button
@export var hand: Control
@export var player_number: int
@export var GameState: Node3D

var to_rotate = false
var is_dragging = false
var local_draggable: Node
var placed = false
var cost: Dictionary

func _ready() -> void:
	icon = cardimg
	local_draggable = draggable.instantiate()
	add_child(local_draggable)
	cost = local_draggable.cost
	local_draggable.set_karte2d(self)
	local_draggable.visible = false
	cam = get_viewport().get_camera_3d()

func _physics_process(_delta):
	if GameStateWorld.current_phase == GameStateWorld.Phase.PLAYING and is_dragging and not placed:
		update_card_position()

func update_card_position():
	var rayResult: Dictionary = {}
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
		print("Dragging over: ", co.name)
		local_draggable.global_position = Vector3(cam.global_position.x, cam.global_position.y - 1, cam.global_position.z)
		if player_number == 2 and not to_rotate:
			local_draggable.rotation.z = deg_to_rad(180)
			to_rotate = true
		local_draggable.visible = true
		var hand_tween = create_tween()
		hand_tween.tween_property(local_draggable, "position", Vector3(co.global_position.x, 2.0, co.global_position.z), 0.2)
		self.visible = false

func try_to_place_card():
	print("Trying to place card...")
	var space_state = local_draggable.get_world_3d().direct_space_state
	var mouse_pos: Vector2 = get_viewport().get_mouse_position()
	var origin: Vector3 = cam.project_ray_origin(mouse_pos)
	var direction: Vector3 = cam.project_ray_normal(mouse_pos)
	var end: Vector3 = origin + direction * 1000

	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true
	var rayResult = space_state.intersect_ray(query)

	if rayResult.has("collider"):
		print("Ray hit: " + str(rayResult["collider"].name))
		if not can_place_card():
			print("Not enough resources!")
			reset_card_position()
			return

		for res in cost.keys():
			GameState.ressources[res] -= cost[res]

		var co: CollisionObject3D = rayResult["collider"]
		var card_key = cardimg.resource_path

		var x_position = GameState.field_start_x
		var y_position = 0.1
		var z_position = GameState.field_z

		if GameState.placed_cards.has(card_key):
			var stack_count = GameState.placed_cards[card_key].size()
			x_position = GameState.placed_cards[card_key][0].x + (stack_count * 0.2)
		else:
			x_position += GameState.field_spacing * GameState.placed_cards.size()

		var final_position = Vector3(x_position, y_position, z_position)
		print("Placing card at: " + str(final_position))
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
		local_draggable.cardimg_file = cardimg
		local_draggable.option_btn = option_btn
		local_draggable.weiter_btn = weiter_btn
		local_draggable.hand = hand
		local_draggable.player_number = player_number
		local_draggable.cam = cam
		local_draggable.GameState = GameState

		card_placed.emit(self, local_draggable)
		print("Card placed and signal emitted!")
	else:
		reset_card_position()

func can_place_card() -> bool:
	for res in cost.keys():
		if GameState.ressources[res] < cost[res]:
			print("Not enough " + res)
			return false
	return true

func reset_card_position():
	placed = false
	is_dragging = false
	local_draggable.visible = false
	self.visible = true
	print("Card placement canceled.")

func _on_button_down() -> void:
	is_dragging = true
	print("Dragging started")

func _on_button_up() -> void:
	is_dragging = false
	print("Mouse released, trying to place card...")
	try_to_place_card()
