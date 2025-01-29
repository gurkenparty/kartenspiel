extends StaticBody2D

var karte: Node2D

func _process(delta: float) -> void:
	
	if global.fokussiertes_feld == self:
		get_tree().create_tween().tween_property(self, "modulate", Color(modulate, 1.0), 0.2).set_ease(Tween.EASE_OUT)
	else:
		get_tree().create_tween().tween_property(self, "modulate", Color(modulate, 0.5), 0.2).set_ease(Tween.EASE_OUT)
	
	if global.ist_am_ziehen:
		visible = true
	else:
		visible = false
