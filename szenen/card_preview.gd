extends Button

signal card_pressed(element)
@export var card_name: String = "New Card"
@export var preview:Texture2D
@export var name_label:Label
@export var preview_sprite:Sprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func change_card_name(card_name:String):
	self.card_name = card_name
func change_preview(deck_preview:Texture2D):
	self.icon = deck_preview


func _on_pressed() -> void:
	if self.card_name != "New Card":
		card_pressed.emit(self)
