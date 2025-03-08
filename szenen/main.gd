extends Node3D
@export var option_btn: Button 
@export var weiter_btn: Button
@onready var player_1_base: Control = get_tree().get_root().find_child("Basis", true, false)
@onready var player_2_base: Control = get_tree().get_root().find_child("Basis2", true, false)
@onready var cam = $Camera3D # Assign Player 1's Camera in the editor
@export var player_number:int 
@export var cam_export:Camera3D
@export var clicktrack:Sprite2D
@onready var hand = $Player1_Hand
var machine = false
var GameState = self
func _ready() -> void:
	
	GameStateWorld.turn_changed.connect(_on_turn_changed)
	
	if player_number == 1:
		GameStateWorld.player_1_cam = cam
		print("Game State World cam 1: " + str(GameStateWorld.player_1_cam))
	elif player_number == 2:
		GameStateWorld.player_2_cam = cam
		cam.rotation.y += deg_to_rad(180)
		print("Game State World cam 2: " + str(GameStateWorld.player_2_cam))
	print("Current Player is: " + str(GameStateWorld.current_player) + " and I, " + str(self.name) + " am: " +str(player_number))
	if GameStateWorld.current_player != player_number:
		self.visible = false
		hand.visible =false
		print(self.name + " visibility is set to "+  str(self.visible))
	print("option_btn:", option_btn)
	print("weiter_btn:", weiter_btn)
	option_btn.option_pressed.connect(_on_option_pressed)
	
	if player_number == 2:
		field_start_x = 9
		field_spacing = -3
		field_z = -1
		print("Current player num 2 and field start loop")
	


func _physics_process(delta):
	if clicktrack:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			clicktrack.visible = true
			# Get the physics space state
			var space_state = get_world_3d().direct_space_state

			# Get the mouse position in the viewport
			var mouse_pos = get_viewport().get_mouse_position()

			# Get camera node (make sure the path is correct)
			var camera = $Camera3D

			# Compute ray origin and direction
			var origin = camera.project_ray_origin(mouse_pos)
			var end = origin + camera.project_ray_normal(mouse_pos) * 10  # Ray length
			#if player_number == 2:
				#mouse_pos.x = mouse_pos.x *-1
			clicktrack.global_position = Vector2(mouse_pos.x, mouse_pos.y)
			print("PLayer " + str(player_number) + "mouse position is: " + str(mouse_pos))
			# Create raycast query
			var query = PhysicsRayQueryParameters3D.create(origin, end)
			query.collide_with_areas = true  # Include areas in collision detection

			# Perform the raycast
			var rayResult: Dictionary = space_state.intersect_ray(query)

			# Check if the ray hit something
			if rayResult.size() > 0:

				# Get the collided object
				var co: CollisionObject3D = rayResult.get("collider")
func _on_turn_changed(new_player:int):
	if GameStateWorld.current_player != player_number:
		print("Current Player is: " + str(GameStateWorld.current_player) + " and I, " + str(self.name) + " am: " +str(player_number))
		self.visible = false
	if GameStateWorld.current_player== player_number:
		print("Current Player is: " + str(GameStateWorld.current_player) + " and I, " + str(self.name) + " am: " +str(player_number))
		self.visible = true
		

var placed_cards = {}  # Stores placed card positions
var field_start_x = -9.0  # Left-most position on the field
var field_spacing = 3  # Distance between cards
var field_z = 1  # Fixed z-axis position
var placed_3d_cards = []
var selected_cards = []
var attack_mode = false
var ressources = {"Holz" : 30, "Stein" : 30, "Metall" : 30, "Amethyst" : 0, "Gold" : 0}

	
func set_attack_mode():
	if GameStateWorld.current_phase == GameStateWorld.Phase.FIGHTING and player_number == GameStateWorld.current_player:
		if selected_cards.size() > 0:
		
			option_btn.text = "Mit " + str(selected_cards.size()) + " Truppen angreifen"
			option_btn.visible = true
			option_btn.preview = false
			weiter_btn.visible = false
		else:
			option_btn.visible = false
			weiter_btn.visible = true
			option_btn.preview = true
func _on_option_pressed():
	if GameStateWorld.current_phase == GameStateWorld.Phase.FIGHTING:
		if selected_cards.size() > 0:
			print(selected_cards)
			player_attacking(player_number, selected_cards)
			option_btn.visible = false
			weiter_btn.visible = true
			GameStateWorld.next_phase()
			
func player_attacking(player:int, attack:Array):
	if player == 1:
		for card in attack:
			player_2_base.change_hp_base(card.angriff*-1)
	elif player == 2:
		for card in attack:
			player_1_base.change_hp_base(card.angriff*-1)
			
			
