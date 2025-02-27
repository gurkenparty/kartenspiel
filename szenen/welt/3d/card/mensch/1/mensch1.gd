extends Node3D

@export var cam: Camera3D # Get the active camera
@export var angriff: int = 0
@export var leben: int = 0
@export var headclass = "Mensch"
@export var subclass = ""
@export var rating = 1
@export var cost = {"Holz":0,"Stein":0,"Metall":0,"Amethyst":0}
@export var init_angriff: int
@export var init_leben: int
@export var standard_texture: Texture2D = preload("res://assets/card/card_textures/texture_black_paper.jpg")
@export var selection_material_texture: Texture2D = preload("res://assets/card/card_selectable.jpg")
@export var selected_material_texture: Texture2D = preload("res://assets/card/card_selected.jpg")
@export var cardmenu : PackedScene
@export var cardimg_file = Texture2D
@export var cardimg_scene: PackedScene = preload("res://szenen/welt/3d/hand/preview.tscn")
@export var option_btn : Button
@export var weiter_btn : Button
@onready var attack_label = $Stats/angriff
@onready var health_label = $Stats/leben
@onready var select_border = $MeshInstance3D
@onready var cardimg = $Sprite3D
@onready var collision_area = $Area3D
var overlap_areas: Array[Area3D]
var original_position: Vector3
var played = false
var effect_placed = false
var selected = false
var selection = false

var selection_material
var selected_material
var standard_material
var move_distance_areas = []
var temporary_move_distance = 0
var instantiated_cardimg_scene
@export var new_card: Node
var karte2d: Button  # Reference to the 2D card
signal card_selected(card, distance)
var cardmenu_path
func _ready():
	set_process(true)
	add_to_group("Truppe")  # General troop group
	add_to_group(str(headclass))  # Head class
	add_to_group(str(subclass))  # Subclass
	update_labels()
	set_process_input(true)  # Enable input processing
	init_angriff = angriff
	init_leben = leben
	update_labels()
	
	
	# Connect signals if karte2d is assigned
	if karte2d:
		karte2d.card_placed.connect(_on_card_placed)

func _input(event):
	if played and event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var ray_origin = cam.project_ray_origin(event.position)
		var ray_direction = cam.project_ray_normal(event.position) * 1000  # Extend ray

		var space_state = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_origin + ray_direction)
		query.collide_with_areas = true  # Ensure areas are considered

		var result = space_state.intersect_ray(query)

		if result.has("collider"):
			print("Ray hit something:", result["collider"], " but self is: ", str(self), " and self are is: " , str(collision_area))
			if result["collider"] == collision_area:
				print("Ray hit this card!")
				if selection:
					print("selection if loop")
					set_selected()
				else:
					print("Not selection")
					if cardimg_scene:
						print("In cardimg if loop")
						instantiated_cardimg_scene = cardimg_scene.instantiate()
						print("Card scene: " + str(instantiated_cardimg_scene) + " instantiated")
						add_child(instantiated_cardimg_scene)
						instantiated_cardimg_scene.weiter_btn = weiter_btn
						print("Card scene: " + str(instantiated_cardimg_scene) + " added as child")
						instantiated_cardimg_scene.texture = cardimg_file
						instantiated_cardimg_scene.visible = true
						print("Card scene: " + str(instantiated_cardimg_scene) + " visibility: " + str(instantiated_cardimg_scene.visible))
						option_btn.text = str(self.name) + " Vorschau ausblenden"
						option_btn.visible = true
						option_btn.connect("option_pressed", _on_option_pressed)
						print(self.name, " got the signal from ", str(option_btn))
						weiter_btn.visible = false
						print("Card scene: " + str(instantiated_cardimg_scene) + " texture: " + str(instantiated_cardimg_scene.texture))
					else:
						print("Error: cardimg_scene is null!")
					
			else:
				print("Ray hit another object:", result["collider"])
		else:
			print("Ray did not hit anything.")
				# Do something while still colliding, e.g., update position

func _on_card_placed(card, card3d):
	print("Karte3D detected that a card was placed:", card.name)
	if not effect_placed:
		add_to_group("feld")
		played = true
		apply_effect()
		effect_placed = true
		GameStateWorld.phase_changed.connect(_on_phase_changed)

func _on_phase_changed(new_phase: int):
	if new_phase == GameStateWorld.Phase.FIGHTING:
		selection_on()
	elif new_phase == GameStateWorld.Phase.LAST_EFFECT:
		print("New phase is after fight")
		selection_off()

func selection_on():
	original_position = self.global_position
	select_border.scale += Vector3(0.3, 0.3, 0)   
	selection_material = StandardMaterial3D.new()
	selection_material.albedo_texture = selection_material_texture
	select_border.material_override = selection_material
	selection = true
	for card in get_tree().get_nodes_in_group("feld"):
		card.card_selected.connect(_on_card_selected)
		print(self.name + " connected to " + card.name)

func selection_off():
	self.global_position = original_position
	remove_from_group("selected")
	selected = false
	GameState.selected_cards.erase(self)
	print("Selection off")
	select_border.scale -= Vector3(0.3, 0.3, 0)
	standard_material = StandardMaterial3D.new()
	standard_material.albedo_texture = standard_texture
	print("Standard Material for: " + str(self.name) + " applied")
	select_border.material_override = standard_material
	print("Standard material is: " +str(standard_material))
	print("Material for border of " + str(self.name) + " is: "+ str(select_border.get_active_material(0)))
	selection = false
	for card in get_tree().get_nodes_in_group("feld"):
		card.card_selected.disconnect(_on_card_selected)
		print(self.name + " disconnected from " + card.name)
	
func set_selected():
	if selection and not selected:
		selected_material = StandardMaterial3D.new()
		selected_material.albedo_texture = selected_material_texture
		select_border.material_override = selected_material
		print("Selected Material for: " + str(self.name) + " applied")
		add_to_group("selected")
		selected = true
		temporary_move_distance = move_distance_areas.size()
		emit_signal("card_selected", self, move_distance_areas.size())
		print(self.name + " move distance: " + str(move_distance_areas.size()))
		GameState.selected_cards.append(self)
		print(self.name + " emitted: " + str(card_selected))
		GameState.set_attack_mode()
	elif selection and selected:
		selection_material = StandardMaterial3D.new()
		selection_material.albedo_texture = selection_material_texture
		select_border.material_override = selection_material
		print("Selection Material for: " + str(self.name) + " applied")
		remove_from_group("selected")
		selected = false
		emit_signal("card_selected", self, temporary_move_distance*-1)
		GameState.selected_cards.erase(self)
		GameState.set_attack_mode()
		
func update_labels():
	attack_label.text = str(angriff)
	health_label.text = str(leben)
	
func apply_effect():
	print("No Effect for card: " + self.name + " set.")
	
func set_karte2d(card: Button):
	karte2d = card
	if karte2d:
		karte2d.card_placed.connect(_on_card_placed)

func change_values(value: String, change: int):
	var color_black = Color(0, 0, 0)  # Default color
	var color_red = Color(1, 0, 0)  # Red for decrease
	var color_green = Color8(38, 104, 24)  # Green for increase
	
	if value == "angriff":
		angriff += change
		attack_label.text = str(angriff)

		# Change color based on comparison with initial value
		if angriff < init_angriff:
			attack_label.modulate = color_red
		elif angriff > init_angriff:
			attack_label.modulate = color_green
		else:
			attack_label.modulate = color_black

	elif value == "leben":
		leben += change
		health_label.text = str(leben)

		# Change color based on comparison with initial value
		if leben < init_leben:
			health_label.modulate = color_red
		elif leben > init_leben:
			health_label.modulate = color_green
		else:
			health_label.modulate = color_black

	update_labels()

func _on_card_selected(card, distance):
	print(self.name + " doing on card function")
	# Debug the overlap_areas and card comparison
	if self.global_position.x > card.global_position.x:
		print(self.name +" moved for distance: "+ str(distance))
		self.global_position += Vector3(distance*2, 0,0)

func _on_area_3d_area_entered(area: Area3D):
	if area.name != "Spielfeld":
		move_distance_areas.append(area)
		print(self.name + " move distance areas: " + str(move_distance_areas))
	if area.name != "Spielfeld" and not overlap_areas.has(area) and self.global_position.x > area.global_position.x:
		overlap_areas.append(area)
		print("Colliding with " + area.name)

func _on_area_3d_area_exited(area: Area3D):
	if overlap_areas.has(area):
		overlap_areas.erase(area)
		print("Stopped colliding with " + area.name)
	if move_distance_areas.has(area):
		move_distance_areas.erase(area)

func _handle_overlap():
	print(self.name + " is in handle overlap")
	self.global_position += Vector3(2*overlap_areas.size(), 0, 0)
	overlap_areas.clear()
	
func _on_option_pressed():
	if instantiated_cardimg_scene.visible == true:
		instantiated_cardimg_scene.visible = false
		option_btn.visible = false
