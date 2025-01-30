extends Node2D

@export var card_scene: PackedScene  # Assign the Card.tscn in the inspector
var cards: Array = []
var cards_num = 0
func add_card():
	if not card_scene:
		print("Error: Card scene not assigned!")
		return

	var card = card_scene.instantiate()
	add_child(card)
	cards.append(card)
	update_card_positions()  # Ensure cards are arranged properly

func update_card_positions():
	var spacing = 100  
	var arc_radius = 300  
	var total_cards = cards.size()

	for i in range(total_cards):
		var card = cards[i]
		
		var angle = deg_to_rad(-30 + (i * 60.0 / max(1, total_cards - 1)))  
		var x = arc_radius * sin(angle)
		var y = arc_radius * (1 - cos(angle))  

		var target_position = Vector2(x, y)
		card.position = target_position
		card.default_position = target_position  # IMPORTANT: Set default_position properly
		card.rotation_degrees = rad_to_deg(angle) / 2  

func _ready() -> void:
	while cards_num < 5:
		add_card()
		cards_num = cards_num +1
		print("Cardnum: " + str(cards_num))
