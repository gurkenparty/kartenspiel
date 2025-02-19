extends Node  # Or MeshInstance or PlaneMesh, depending on your setup

func _ready():
	pass

# Define a simple bounding box for the board's area
func get_rect() -> Rect2:
	var board_size = Vector2(10, 10)  # Example size of the game board
	return Rect2(Vector2(-board_size.x / 2, -board_size.y / 2), board_size)
