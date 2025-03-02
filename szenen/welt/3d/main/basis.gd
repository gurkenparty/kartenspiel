extends Control
@export var player:int
@export var label: Label
var hp = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = str(hp)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func change_hp_base(value:int):
	hp += value
	label.text = str(hp)
	if hp <= 0 and self.visible:
		label.visible = false
		self.visible = false
