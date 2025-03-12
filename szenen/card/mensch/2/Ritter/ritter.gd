extends "res://szenen/card/mensch/main.gd"


func _ready():
	cost = {"Holz":1, "Stein":4, "Metall":1}
	angriff = 1  
	leben = 4
	headclass = "Mensch"
	subclass = "Ritter"
	rating = 2
	add_to_group("Mensch")
	add_to_group("Ritter")  
	update_labels()

func _on_card_placed(card, card3d):
	if not effect_placed:
		played = true
		add_to_group("feld")
		effect_placed = true
		hand.card_3d_effector.connect(_on_other_3d_card_placed)

func _on_other_3d_card_placed(card3d:Node3D):
	print_debug(self.name + " detected that a card was placed:", card3d.name)
	if card3d != self and card3d.is_in_group("Ritter"):
		apply_effect()

func apply_effect():
	weiter_btn.visible = false
	print_debug(self.name + " is in group Truppe: " + str(self.is_in_group("Truppe")))
	# Instantiate the preview card image
	var instantiated_cardimg_scene = cardimg_scene.instantiate()
	print_debug("Card scene: " + str(instantiated_cardimg_scene) + " instantiated")
	add_child(instantiated_cardimg_scene)
	instantiated_cardimg_scene.weiter_btn = weiter_btn
	print_debug("Card scene: " + str(instantiated_cardimg_scene) + " added as child")
	instantiated_cardimg_scene.texture = cardimg_file
	instantiated_cardimg_scene.visible = true
	print_debug("Applying effect...")
	await get_tree().create_timer(2.0).timeout  # Wait for 2 seconds before hiding the preview
	hand.spawn_hand_cards(1)
	instantiated_cardimg_scene.visible = false
	instantiated_cardimg_scene.queue_free()
	weiter_btn.visible = true
