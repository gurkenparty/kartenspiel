extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_DropArea_body_entered"))


func _on_DropArea_body_entered(body: Node) -> void:
	if body.is_in_group("cards"):
		# Karte auf Drop-Position ablegen
		body.drop_to_board(global_position)
