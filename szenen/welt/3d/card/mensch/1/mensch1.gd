extends Node3D  # Base class for all troops

@export var angriff: int = 0
@export var leben: int = 0

@onready var attack_label = $Stats/angriff
@onready var health_label = $Stats/leben

var played = false
var effect_placed = false
@export var new_card: Node
var karte2d: Button  # Reference to the 2D card
@onready var select_border = $MeshInstance3D
var selected = false  # Global selected state, not local

var init_angriff: int
var init_leben: int

func _ready():
	add_to_group("Truppe")  # General troop group
	init_angriff = angriff
	init_leben = leben
	update_labels()

	# Don't connect the signal in _ready(), wait until karte2d is set
	if karte2d:
		karte2d.card_placed.connect(_on_card_placed)

func _on_phase_changed(new_phase: int):
	if new_phase == GameStateWorld.Phase.FIGHTING:
		selection_on()  # Trigger the selection_on function when the Fighting phase starts
	elif new_phase == GameStateWorld.Phase.LAST_EFFECT:
		print("new phase is after fight")
		selection_off()  # Turn off selection when not in Fighting phase
	else:
		pass

func set_karte2d(card: Button):
	karte2d = card
	if karte2d:
		karte2d.card_placed.connect(_on_card_placed)

func update_labels():
	attack_label.text = str(angriff)
	health_label.text = str(leben)

# To be overridden by subclasses
func apply_effect():
	print(name + " has no effect defined!")

func _on_card_placed(card):
	print("Karte3D detected that a card was placed:", card.name)
	if not effect_placed:
		add_to_group("feld")
		apply_effect()
		effect_placed = true
		GameStateWorld.phase_changed.connect(_on_phase_changed)

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

# Activate selection (increase scale and apply material)
func selection_on():
	print("select mode on. Old card scale: " +str(select_border.scale))
	select_border.scale += Vector3(0.3, 0, 0.3)  # Increase scale by 0.3 on X and Z axes
	print("current card scale: " + str(select_border.scale))
	# Create a new material
	var new_material = StandardMaterial3D.new()
	
	# Set a texture for the material
	var texture = preload("res://assets/card/card_selectable.jpg")  # Load texture
	new_material.albedo_texture = texture  # Apply texture to the material
	
	# Apply the new material to the mesh
	select_border.material_override = new_material
	selected = true  # Directly update the global `selected` variable
	print("selected is true")

# Function to deactivate selection (reset scale and material)
func selection_off():
	if selected == true:
		print("selection off function")
		select_border.scale -= Vector3(0.3, 0, 0.3)  # Reset scale to normal (or any desired size)
		print("new scale is: " + str(select_border.scale))
		# Optionally reset the material (if you want to go back to the original one)
		var original_material = StandardMaterial3D.new()  # or preload the default material
		select_border.material_override = original_material
		selected = false  # Reset the global `selected` variable
