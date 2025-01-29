extends StaticBody2D

var karte: Node2D

func _process(delta: float) -> void:
	if global.fokussiertes_feld == self:
		self.modulate.a = 1
	else:
		self.modulate.a = 0.5
	
	if global.ist_am_ziehen:
		visible = true
	else:
		visible = false
