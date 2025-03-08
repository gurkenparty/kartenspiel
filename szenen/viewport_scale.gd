extends SubViewportContainer


func _ready():
	var sub_viewport = $SubViewport
	sub_viewport.size = target_resolution
	stretch = true  # Enable stretching
	stretch_shrink = 1  # Optional: Adjust as needed
