class_name Mensch
extends Karte

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.title = "Mensch"
	self.typ = "Truppe"
	self.leben = 5
	self.angriff = 5
	super._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
