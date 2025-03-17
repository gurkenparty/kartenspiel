extends Node

var username = "Sean Test"
var avatar = load("res://assets/wallpapers/Wallpaper_knight_mid_street.png")
var favourite_cards = {}
var wins = 0
var draws = 0
var loss = 0
var elo = 100
var decks = []
var selected_deck:Deck
var user_cards = [
	
]  # Stores the card names
func _ready() -> void:
	var deck_img = load("res://assets/characters/mensch/6/Urus/Urus_cropped.png")
	Deck.new("DemoDeck", deck_img, ["Knappe","Knappe","Knappe","Knappe","Landwirtin","Landwirtin","Landwirtin","Landwirtin"])
