extends Button

signal element_pressed(element)
@export var deck_name: String = "New Deck"
@export var preview:Texture2D
@export var name_label:Label
@export var preview_sprite:Sprite2D
@export var deck:Deck
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func change_deck_name(deck_name:String):
	self.deck_name = deck_name
	name_label.text = deck_name
func change_preview(deck_preview:Texture2D):
	preview_sprite.texture = deck_preview


func _on_pressed() -> void:
	element_pressed.emit(self)
