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

var draggable: bool = false
var inside_droppable: bool = false
var droppable: Node2D
var offset: Vector2
var initial_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_card("Knappe")

func _process(delta: float) -> void:
	if draggable:
		if Input.is_action_pressed("click"):
			print("press")
			initial_position = global_position
			global_position = get_global_mouse_position()
			offset = get_global_mouse_position() - global_position
			global.is_dragging = true
		elif Input.is_action_just_released("click"):
			print("release")
			global.is_dragging = false
			var tween = get_tree().create_tween()
			if inside_droppable:
				tween.tween_property(self, "position", droppable.position, 0.2).set_ease(Tween.EASE_OUT)
			else:
				tween.tween_property(self, "global_position", initial_position, 0.2).set_ease(Tween.EASE_OUT)

func _on_area_mouse_entered() -> void:
	if not global.is_dragging:
		draggable = true
		scale = scale * 1.01

func _on_area_mouse_exited() -> void:
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
