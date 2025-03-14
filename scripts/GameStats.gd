extends Node

var favourite_cards = {}
var wins = 0
var draws = 0
var loss = 0
var elo = 100
var decks = []
var selected_deck:Deck
var user_cards = [
	"Knappe", "Knappe", "Knappe", "Knappe",
	"Landwirtin", "Landwirtin", "Landwirtin", "Landwirtin",
	"Joker", "Ritter", "Assasine", "Grundbesitzerin",
	"Graf_Zacharias", "Gerd", "Urus", "Bär",
	"Gift", "Späher", "Muti", "Stratege", "Meister",
	"Unge", "Hauer", "Zerfleischer", "EF", "RO", "Kirill", "Blumen", "Erde", 
	"Feuer", "Glas" , "Licht", "Natur", "Schatten", "Stahl", "Wasser", "Xera", "TW", 
	"BB", "EK", "Vet", "Sch", "Schmied", "Erdbro", "Qualle", "Falle", 
	"Holz1", "Holz2", "Holz3", "Holz4",
	"Stein1", "Stein2", "Stein3", "Stein4",
	"Metall1", "Metall2", "Metall3", "Metall4",
	"Amethyst1", "Amethyst2", "Amethyst3", "Amethyst4",

	
]  # Stores the card names
