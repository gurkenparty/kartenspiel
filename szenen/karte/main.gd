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
	var node = get_node('Titel/Text')
	if node and node is Label:
		node.text = self.title
	else:
		print("Node 'Titel/Text' not found or is not a Label")
	get_node('Typ/Text').text = self.typ
	get_node('Level/Text').text = str(self.level)
	get_node('Story/Text').text = self.story
	get_node('Effect/Text').text = self.effekt
	get_node('Stats/Leben').text = str(self.leben)
	get_node('Stats/Angriff').text = str(self.angriff)

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
