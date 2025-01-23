extends StaticBody2D

func _process(delta: float) -> void:
	if global.is_dragging:
		visible = true
	else:
		visible = false
