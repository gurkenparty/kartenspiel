extends Sprite2D
@export var weiter_btn: Button
@export var texture_preview : Texture2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.texture = texture_preview

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_mouse_entered() -> void:
	pass # Replace with function body.


func _on_area_2d_mouse_exited() -> void:
	pass
	
