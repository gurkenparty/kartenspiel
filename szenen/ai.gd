extends Node3D
@export var GameState: Node3D

signal card_played(card)  # Signal when a card is played
signal request_draw_card  # Signal to request a new card from the deck
signal card_3d_effector(card3d)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
