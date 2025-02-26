extends "res://szenen/welt/3d/card/mensch/1/mensch1.gd"


@export var unterstützung: int = 1  

var effect_activated = false  # Ensure effect only runs once # Adjust to the correct path # Disable collision checks at start

func _ready():
	cost = {"Holz":2,"Stein":1,"Metall":0,"Amethyst":0}
	angriff = 1  
	leben = 2
	headclass = "Mensch"
	subclass = "Ritter"
	rating = 1
	cardmenu_path = "res://szenen/welt/3d/card/" + str(headclass.to_lower()) + "/" + str(rating) + "/" + str(self.name).to_lower() + "/cardmenu.tscn"
	print("path for" + str(self.name) + "is: " + str(cardmenu_path))
	cardmenu = load(cardmenu_path)
	standard_texture = preload("res://assets/card/card_textures/texture_black_paper.jpg")
	selection_material_texture = preload("res://assets/card/card_selectable.jpg")
	selected_material_texture = preload("res://assets/card/card_selected.jpg") 
	update_labels()

func _process(_delta):
	pass

func apply_effect():
	print(self.name + " is in group Truppe: " + str(self.is_in_group("Truppe")))
	if effect_activated:
		print("Effect already activated, skipping...")
		return  # Prevent reapplying effect
	
	print("Applying effect...")

	var all_cards_feld = get_tree().get_nodes_in_group("feld")
	var all_cards= []
	for i in all_cards_feld:
		if i.is_in_group("Player1"):
			all_cards.append(i)
	if all_cards.is_empty():
		print("No cards found in 'feld' group!")
		return

	var ritter_cards = []

	for card in all_cards:
		print("Found card:", card.name)  # Debug: Check which cards are found
		if card.is_in_group("Ritter") and card != self:  
			ritter_cards.append(card)
			print(card.name, "is a Ritter!")  # Debug: Confirm Ritter cards found
	
	if ritter_cards.is_empty():
		print("No Ritter cards found to apply effect!")
		return
	
	for ritter in ritter_cards:
		print(ritter.name, "before effect: Angriff =", ritter.angriff)  # Debug
		ritter.change_values("angriff", 1)
		print(ritter.name, "after effect: Angriff =", ritter.angriff) 
		

	effect_activated = true  # Ensure effect only happens once
	print("Effect successfully applied!")
