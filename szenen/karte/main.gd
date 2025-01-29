class_name Karte
extends Node2D

@export var title: String = "Titel"
@export var etikett: String = "Etikett"
@export var tafel: String = "Bacon ipsum dolor amet pastrami fatback pork chop tail, jowl pork loin prosciutto beef sausage shoulder corned beef tongue andouille. Cupim tri-tip frankfurter landjaeger."
@export var level: int = 1
@export var leben: int = 10
@export var angriff: int = 5
@export var platte: Texture2D = load("res://assets/platten/silber.png")
@export var fenster_rahmen: Texture2D = load("res://assets/fenster/kreis/rahmen.png")
@export var fenster_glas: Texture2D = load("res://assets/fenster/kreis/glas.png")
@export var bild: Texture2D = load("res://assets/bilder/neutral landmark.webp")

var draggable: bool = false
var inside_droppable: bool = false
var droppable: Node2D
var offset: Vector2
var initial_position: Vector2

func _init(title = self.title, etikett = self.etikett, tafel = self.tafel, level = self.level, leben = self.leben, angriff = self.angriff, platte = self.platte, fenster_rahmen = self.fenster_rahmen, fenster_glas = self.fenster_glas, bild = self.bild) -> void:
	self.title = title
	self.etikett = etikett
	self.tafel = tafel
	self.level = level
	self.leben = leben
	self.angriff = angriff
	self.platte = platte
	self.fenster_rahmen = fenster_rahmen
	self.fenster_glas = fenster_glas
	self.bild = bild

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node('Titel/Text').text = self.title
	get_node('Etikett/Text').text = self.etikett
	get_node('Level/Text').text = str(self.level)
	get_node('Stats/Leben').text = str(self.leben)
	get_node('Stats/Angriff').text = str(self.angriff)
	get_node('Platte').texture = self.platte
	get_node('Fenster/Rahmen').texture = self.fenster_rahmen
	get_node('Fenster/Glas').texture = self.fenster_glas
	get_node('Fenster/Pfad').texture = self.fenster_rahmen
	get_node('Fenster/Pfad/Bild').texture = self.bild

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
