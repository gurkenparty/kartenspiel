extends Node3D
@export var option_btn: Button 
@export var weiter_btn: Button
@export var player_1_base: Control
@export var player_2_base: Control
@onready var cam = $Camera3D # Assign Player 1's Camera in the editor
@export var player_number:int 
@export var cam_export:Camera3D
@export var clicktrack:Sprite2D
@onready var hand = $Player1_Hand
var machine = false
var GameState = self
func _ready() -> void:
	
	GameStateWorld.turn_changed.connect(_on_turn_changed)
	print_debug("option_btn:", option_btn)
	print_debug("weiter_btn:", weiter_btn)
	option_btn.option_pressed.connect(_on_option_btn_pressed)
	


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
			print_debug("PLayer " + str(player_number) + "mouse position is: " + str(mouse_pos))
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
		print_debug("Current Player is: " + str(GameStateWorld.current_player) + " and I, " + str(self.name) + " am: " +str(player_number))
		self.visible = false
	if GameStateWorld.current_player== player_number:
		print_debug("Current Player is: " + str(GameStateWorld.current_player) + " and I, " + str(self.name) + " am: " +str(player_number))
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
			
			
func player_attacking(player:int, attack:Array):
	print_debug("I am player: " + str(player))
	if player == 1:
		for card in attack:
			print_debug("callig "+ str(player_2_base) + "base to change by: " + str(card.angriff*-1))
			player_2_base.change_hp_base(card.angriff*-1)
	elif player == 2:
		for card in attack:
			print_debug("callig player 1 base to change")
			player_1_base.change_hp_base(card.angriff*-1)
func get_resources():
	return self.ressources
			
			


func _on_option_btn_pressed() -> void:
	if GameStateWorld.current_phase == GameStateWorld.Phase.FIGHTING:
		print_debug("In option attacking loop")
		if selected_cards.size() > 0:
			print_debug("selected cards: " + str(selected_cards))
			player_attacking(player_number, selected_cards)
			option_btn.visible = false
			weiter_btn.visible = true
			GameStateWorld.next_phase()
