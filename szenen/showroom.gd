extends SubViewportContainer

@export var target_resolution : Vector2 = Vector2(DisplayServer.screen_get_size())
@export var scene:Node3D
func _ready():
	var sub_viewport = $SubViewport
	# Set mouse filter to Pass for SubViewportContainer
	self.mouse_filter = Control.MOUSE_FILTER_PASS

	sub_viewport.size = target_resolution
	stretch = true  # Enable stretching
	stretch_shrink = 1  # Optional: Adjust as needed
