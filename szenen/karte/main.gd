@tool
class_name Karte
extends Node2D

@export var title: String = "Titel"
@export var typ: String = "Typ"
@export var story: String = "Story"
@export var effekt: String = "Effekt"
@export var level: int = 1
@export var leben: int = 10
@export var angriff: int = 5
@export var default_position: Vector2
@export var default_rotation: float

var draggable: bool = false
var inside_droppable: bool = false
var droppable: Node2D
var offset: Vector2
var initial_position: Vector2
var is_hovered = false
var is_on_board = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.default_position = position
	call_deferred("_set_default_rotation")
	print("DefaultRotation:" + str(self.default_rotation))
	print("RotationDegreesfromdefault:" + str(rotation_degrees))
	spawn_card("Knappe")
	add_to_group("cards")

func _process(delta: float) -> void:
	if draggable:
		if Input.is_action_pressed("click"):
			# Beim Dragen: direkt an die Mausposition setzen
			# (initial_position nur einmal speichern, z.B. beim Klick-Down)
			if not global.is_dragging:
				initial_position = global_position
			global_position = get_global_mouse_position()
			global.is_dragging = true
		elif Input.is_action_just_released("click"):
			global.is_dragging = false
			var tween = get_tree().create_tween()
			if inside_droppable:
				# Drop-Area-Position aus dem gespeicherten droppable-Node verwen
				tween.tween_property(self, "position", droppable.global_position, 0.2).set_ease(Tween.EASE_OUT)
				# Nach dem Ablegen sollte die Karte nicht mehr draggable sein
				draggable = false
			
			else:
				tween.tween_property(self, "global_position", initial_position, 0.2).set_ease(Tween.EASE_OUT)

func _set_default_rotation():
	self.default_rotation = rotation_degrees  # Store the actual rotation

func _on_area_mouse_entered() -> void:
	is_hovered  = true
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", default_position + Vector2(0,-100), 0.1).set_ease(Tween.EASE_OUT)  # Move up
	tween.tween_property(self, "scale", Vector2(0.2, 0.2), 0.1).set_ease(Tween.EASE_OUT)  # Scale up
	tween.tween_property(self, "rotation_degrees", 0, 0.1).set_ease(Tween.EASE_OUT) 
	print("Rotationdegrees: " + str(rotation_degrees)) # Set rotation to 0# Remove rotation while hovered
	if not global.is_dragging:
		draggable = true
		scale = scale * 1.01

func _on_area_mouse_exited() -> void:
	is_hovered = false
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", default_position, 0.1).set_ease(Tween.EASE_OUT)  # Move back
	tween.tween_property(self, "scale", Vector2(0.1, 0.1), 0.1).set_ease(Tween.EASE_OUT)  # Reset size
	tween.tween_property(self, "rotation_degrees", self.default_rotation, 0.1).set_ease(Tween.EASE_OUT)  # Restore original rotation
	if not global.is_dragging:
		draggable = false
		scale = scale / 1.01

func _on_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("droppable"):
		inside_droppable = true
		droppable = body

func _on_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("droppable"):
		inside_droppable = false
		
func spawn_card(Cardname:String):
	# Pick a card value (you already have this part set)
	# Add card layers (sprites)
	for layer in Cardvals.card_layers:
		var sprite = Sprite2D.new()
	
		if layer == "Character":
			var texture_path = "res://assets/characters/" + Cardvals.typ.to_lower() + "/" + str(Cardvals.level) + "/" + Cardname + ".png"
			var texture = load(texture_path)
			sprite.texture = texture
		else:
			var texture = load(layer)
			if texture:
				sprite.texture = texture
	
	# Adjust scale and z_index of the sprite
		sprite.scale = Vector2(2.5, 2.5)
		sprite.z_index = 0  # Set the z_index to a lower value for the card (background)
	
	# Add the sprite as a child of the current nod
		add_child(sprite)

# Set text 
	get_node('Titel/Text').text = str(Cardvals.title)
	get_node('Typ/Text').text = str(Cardvals.typ)
	get_node('Level/Text').text = str(Cardvals.level)
	get_node('Story/Text').text = str(Cardvals.story)
	get_node('Effect/Text').text = str(Cardvals.effekt)
	get_node('Stats/Leben').text = str(Cardvals.leben)
	get_node('Stats/Angriff').text = str(Cardvals.angriff)

# Set z_index for text labels to ensure they are above the sprites
	get_node('Titel/Text').z_index = 1
	get_node('Typ/Text').z_index = 1
	get_node('Level/Text').z_index = 1
	get_node('Story/Text').z_index = 1
	get_node('Effect/Text').z_index = 1
	get_node('Stats/Leben').z_index = 1
	get_node('Stats/Angriff').z_index = 1


	
	self.title = Cardvals.title
	self.typ = Cardvals.typ
	self.level = Cardvals.level
	self.story = Cardvals.story
	self.effekt = Cardvals.effekt
	self.leben = Cardvals.leben
	self.angriff = Cardvals.angriff



# Diese Funktion wird von der DropArea aufgerufen, wenn die Karte abgelegt wird
func drop_to_board(drop_position: Vector2) -> void:
	if is_on_board:
		return  # Falls die Karte schon abgelegt ist, mache nichts

	is_on_board = true

	# Verschiebe die Karte zur Drop-Position (kannst du auch anpassen, z.B. mit einem kleinen Offset)
	position = drop_position

	# Ändere die Skalierung, um die Karte kleiner darzustellen
	# Hier auf 50 % der Originalgröße; passe den Wert bei Bedarf an
	scale = Vector2(0.5, 0.5)

	# Optional: Wenn du eine Animation haben möchtest, könntest du hier eine Tween-Animation starten.
