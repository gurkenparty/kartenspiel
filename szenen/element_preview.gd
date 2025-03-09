extends Button

@export var deck_name: String = "New Deck"
@export var preview:Texture2D
@export var name_label:Label
@export var preview_sprite:Sprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	name_label.text = deck_name
	preview_sprite.texture = preview


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
