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
@export var feld: Node2D

var ist_im_fokus: bool = false
var basis_scale: Vector2;

func _init(title = self.title, etikett = self.etikett, tafel = self.tafel, level = self.level, leben = self.leben, angriff = self.angriff, platte = self.platte, fenster_rahmen = self.fenster_rahmen, fenster_glas = self.fenster_glas, bild = self.bild, feld = self.feld) -> void:
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
	self.feld = feld

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node('Titel/Text').text = title
	get_node('Etikett/Text').text = etikett
	get_node('Level/Text').text = str(level)
	get_node('Stats/Leben').text = str(leben)
	get_node('Stats/Angriff').text = str(angriff)
	get_node('Platte').texture = platte
	get_node('Fenster/Rahmen').texture = fenster_rahmen
	get_node('Fenster/Glas').texture = fenster_glas
	get_node('Fenster/Pfad').texture = fenster_rahmen
	get_node('Fenster/Pfad/Bild').texture = bild
	
	if not feld:
		var felder = get_tree().get_nodes_in_group("feld")
		var nähstes_feld = felder[0]
		for feld in felder:
			var distanz = global_position.distance_to(feld.global_position)
			if distanz < global_position.distance_to(nähstes_feld.global_position):
				nähstes_feld = feld
		feld = nähstes_feld
		
	position = feld.position
	basis_scale = scale
	

func _process(delta: float) -> void:
	if ist_im_fokus:
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position()
			if not global.ist_am_ziehen:
				global.ist_am_ziehen = true
				global.fokussiertes_feld = feld
				var neue_scale = Vector2(basis_scale.x*1.1, basis_scale.y/1.1)
				get_tree().create_tween().tween_property(self, "scale", neue_scale, 0.1).set_ease(Tween.EASE_OUT)
			
		elif Input.is_action_just_released("click"):
			global.ist_am_ziehen = false
			
			feld.karte = null
			global.fokussiertes_feld.karte = self
			feld = global.fokussiertes_feld
			global.fokussiertes_feld = null
			get_tree().create_tween().tween_property(self, "position", feld.position, 0.2).set_ease(Tween.EASE_OUT)
			get_tree().create_tween().tween_property(self, "scale", basis_scale, 0.1).set_ease(Tween.EASE_OUT)

func _on_area_mouse_entered() -> void:
	if not global.ist_am_ziehen:
		ist_im_fokus = true

func _on_area_mouse_exited() -> void:
	if not global.ist_am_ziehen:
		ist_im_fokus = false

func _on_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("feld"):
		if not body.karte:
			global.fokussiertes_feld = body

func _on_area_body_exited(body: Node2D) -> void:
	if body == global.fokussiertes_feld:
		global.fokussiertes_feld = feld
