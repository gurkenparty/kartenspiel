extends Camera2D

@export var zoom_step: float = 0.1  # Amount to zoom per step
@export var min_zoom: float = 0.5   # Minimum zoom level
@export var max_zoom: float = 3.0   # Maximum zoom level

func _input(event):
	if event is InputEventKey:
		if event.button_index == KEY_UP:
			zoom_in()
		elif event.button_index == KEY_DOWN:
			zoom_out()

func zoom_in():
	var new_zoom = zoom - Vector2(zoom_step, zoom_step)
	if new_zoom.x >= min_zoom and new_zoom.y >= min_zoom:
		zoom = new_zoom

func zoom_out():
	var new_zoom = zoom + Vector2(zoom_step, zoom_step)
	if new_zoom.x <= max_zoom and new_zoom.y <= max_zoom:
		zoom = new_zoom
