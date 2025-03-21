extends SubViewportContainer

@export var target_resolution : Vector2 = Vector2(DisplayServer.screen_get_size())
@export var scene:Node3D
@export var spielen_btn:Button
func _ready():
	var sub_viewport = $SubViewport
	# Set mouse filter to Pass for SubViewportContainer
	
	stretch = true  # Enable stretching
	stretch_shrink = 1  # Optional: Adjust as needed


func _on_decks_pressed() -> void:
	var sub_viewport = $SubViewport
	var childs = sub_viewport.get_children()
	spielen_btn.visible = false
	for child in childs:
		if child.name != "Deckmenu":
			child.visible = false
		else:
			child.visible = true
		


func _on_showroom_pressed() -> void:
	var sub_viewport = $SubViewport
	var childs = sub_viewport.get_children()
	spielen_btn.visible = true
	for child in childs:
		if child.name != "showroom":
			child.visible = false
		else:
			child.visible = true


func _on_packs_pressed() -> void:
	var sub_viewport = $SubViewport
	var childs = sub_viewport.get_children()
	spielen_btn.visible = false
	for child in childs:
		if child.name != "Packwindow":
			child.visible = false
		else:
			child.visible = true
