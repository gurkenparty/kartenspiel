extends Button
signal option_pressed
@onready var weiter_btn: Button = get_tree().get_root().find_child("weiter", true, false)
var preview = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	if preview:
		weiter_btn.visible = true
	option_pressed.emit()
	print("option button emitted")
