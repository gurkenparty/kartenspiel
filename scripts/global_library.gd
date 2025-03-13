extends  Node3D
var cards = {
	"Knappe": {
		"texture": preload("res://assets/characters/mensch/1/Knappe/knappe.png"),
		"draggable_scene": preload("res://szenen/card/mensch/1/Knappe/Knappe.tscn")
	},
	"Landwirtin": {
		"texture": preload("res://assets/characters/mensch/1/Landwirtin/Landwirtin.png"),
		"draggable_scene": preload("res://szenen/card/mensch/1/Landwirtin/Landwirtin.tscn")
	},
	"Joker": {
		"texture": preload("res://assets/characters/mensch/1/Joker/Joker.png"),
		"draggable_scene": preload("res://szenen/card/mensch/1/Joker/Joker.tscn")
	},
	"Ritter": {
		"texture": preload("res://assets/characters/mensch/2/Ritter/Ritter.png"),
		"draggable_scene": preload("res://szenen/card/mensch/2/Ritter/ritter.tscn")
	},
	"Assasine": {
		"texture": preload("res://assets/characters/mensch/2/Assasine/Assasine.png"),
		"draggable_scene": preload("res://szenen/card/mensch/2/Assasine/Assasine.tscn")
	},
	"Grundbesitzerin": {
		"texture": preload("res://assets/characters/mensch/3/Grundbesitzerin/Grundbesitzerin.png"),
		"draggable_scene": preload("res://szenen/card/mensch/3/Grundbesitzerin/Grundbesitzerin.tscn")
	},
	"Graf_Zacharias": {
		"texture": preload("res://assets/characters/mensch/4/Graf_Zacharias/Zacharias.png"),
		"draggable_scene": preload("res://szenen/card/mensch/4/Graf_Zacharias/graf_zacharias.tscn")
	},
	"Gerd": {
		"texture": preload("res://assets/characters/mensch/5/Gerd/Gerd.png"),
		"draggable_scene": preload("res://szenen/card/mensch/5/Koenig_Gerd/koenig_gerd.tscn")
	},
	"Urus": {
		"texture": preload("res://assets/characters/mensch/6/Urus/Urus.png"),
		"draggable_scene": preload("res://szenen/card/mensch/6/Lord_Urus/Lord_Urus.tscn")
	},
	"Bär": {
		"texture": preload("res://assets/characters/kobold/1/Bär/Bär.png"),
		"draggable_scene": preload("res://szenen/card/kobold/1/Bär/bär.tscn")
	},
	"Gift": {
		"texture": preload("res://assets/characters/kobold/2/Gift/Gift.png"),
		"draggable_scene": preload("res://szenen/card/kobold/2/Gift/gift.tscn")
	},
	"Späher": {
		"texture": preload("res://assets/characters/kobold/3/Späher/Späher.png"),
		"draggable_scene": preload("res://szenen/card/kobold/3/Späher/späher.tscn")
	},
	"Muti": {
		"texture": preload("res://assets/characters/kobold/4/Muti/Muti.png"),
		"draggable_scene": preload("res://szenen/card/kobold/4/Muti/Muti.tscn")
	},
	"Stratege": {
		"texture": preload("res://assets/characters/kobold/5/Stratege/Stratege.png"),
		"draggable_scene": preload("res://szenen/card/kobold/5/Stratege/Stratege.tscn")
	},
	"Meister": {
		"texture": preload("res://assets/characters/kobold/6/Meister/Meister.png"),
		"draggable_scene": preload("res://szenen/card/kobold/6/Meister/Meister.tscn")
	},
	"Unge": {
		"texture": preload("res://assets/characters/ork/1/Ungelehrter/Ungelehrter.png"),
		"draggable_scene": preload("res://szenen/card/ork/1/Ungelehrter/Unge.tscn")
	},
	"Hauer": {
		"texture": preload("res://assets/characters/ork/2/hauer/hauer.png"),
		"draggable_scene": preload("res://szenen/card/ork/2/Hauer/Hauer.tscn")
	},
	"Zerfleischer": {
		"texture": preload("res://assets/characters/ork/3/Zerfleischer/Cropped.png"),
		"draggable_scene": preload("res://szenen/card/ork/3/Zerfleischer/Zerfleischer.tscn")
	},
	"EF": {
		"texture": preload("res://assets/characters/ork/4/EF/EF.png"),
		"draggable_scene": preload("res://szenen/card/ork/4/FetterReiter/EF.tscn")
	},
	"RO": {
		"texture": preload("res://assets/characters/ork/5/RO/RO.png"),
		"draggable_scene": preload("res://szenen/card/ork/5/OgerOrk/RO.tscn")
	},
	"Kirill": {
		"texture": preload("res://assets/characters/ork/6/Kirill/Kirill.png"),
		"draggable_scene": preload("res://szenen/card/ork/6/Kirill/Kirill.tscn")
	},
	"Blumen": {
		"texture": preload("res://assets/characters/drache/Blumen.png"),
		"draggable_scene": preload("res://szenen/card/drache/Blumen.tscn")
	},
	"Erde": {
		"texture": preload("res://assets/characters/drache/Erde.png"),
		"draggable_scene": preload("res://szenen/card/drache/Erde.tscn")
	},
	"Feuer": {
		"texture": preload("res://assets/characters/drache/Feuer.png"),
		"draggable_scene": preload("res://szenen/card/drache/Feuer.tscn")
	},
	"Glas": {
		"texture": preload("res://assets/characters/drache/Glas.png"),
		"draggable_scene": preload("res://szenen/card/drache/Glass.tscn")
	},
	"Licht": {
		"texture": preload("res://assets/characters/drache/Licht.png"),
		"draggable_scene": preload("res://szenen/card/drache/Licht.tscn")
	},
	"Natur": {
		"texture": preload("res://assets/characters/drache/Natur.png"),
		"draggable_scene": preload("res://szenen/card/drache/Natur.tscn")
	},
	"Schatten": {
		"texture": preload("res://assets/characters/drache/Schatten.png"),
		"draggable_scene": preload("res://szenen/card/drache/Schatten.tscn")
	},
	"Stahl": {
		"texture": preload("res://assets/characters/drache/Stahl.png"),
		"draggable_scene": preload("res://szenen/card/drache/Stahl.tscn")
	},
	"Wasser": {
		"texture": preload("res://assets/characters/drache/Wasser.png"),
		"draggable_scene": preload("res://szenen/card/drache/Wasser.tscn")
	},
	"Sch": {
		"texture": preload("res://assets/characters/elf/1/Schneiderin/Sch.png"),
		"draggable_scene": preload("res://szenen/card/elf/1/Sch/Sch.tscn")
	},
	"Vet": {
		"texture": preload("res://assets/characters/elf/2/Veteranin/Vet.png"),
		"draggable_scene": preload("res://szenen/card/elf/2/Vet/Vet.tscn")
	},
	"EK": {
		"texture": preload("res://assets/characters/elf/3/Elegante Bitch/EK.png"),
		"draggable_scene": preload("res://szenen/card/elf/3/EK/EK.tscn")
	},
	"BB": {
		"texture": preload("res://assets/characters/elf/4/Bestein Beschwörerin/BB.png"),
		"draggable_scene": preload("res://szenen/card/elf/4/BB/BB.tscn")
	},
	"TW": {
		"texture": preload("res://assets/characters/elf/5/Tempelwächterin/TW.png"),
		"draggable_scene": preload("res://szenen/card/elf/5/TW/TW.tscn")
	},
	"Xera": {
		"texture": preload("res://assets/characters/elf/6/Xera/Xera.png"),
		"draggable_scene": preload("res://szenen/card/elf/6/Xera/Xera.tscn")
	},
	"Schmied": {
		"texture": preload("res://assets/characters/extra/Schmied.png"),
		"draggable_scene": preload("res://szenen/extra/schmied.tscn")
	},
	"Erdbro": {
		"texture": preload("res://assets/characters/extra/ERDSCHWANZ.png"),
		"draggable_scene": preload("res://szenen/extra/erdbro.tscn")
	},
	"Falle": {
		"texture": preload("res://assets/characters/extra/Falle.png"),
		"draggable_scene": preload("res://szenen/extra/falle.tscn")
	},
	"Qualle": {
		"texture": preload("res://assets/characters/extra/qualle.png"),
		"draggable_scene": preload("res://szenen/extra/qualle.tscn")
	},
	"Holz1": {
		"texture": preload("res://assets/characters/gebaeude/sammler/Hloz/h1.png"),
		"draggable_scene": preload("res://szenen/aBuilding/sammler/holz1.tscn")
	},
	"Holz2": {
		"texture": preload("res://assets/characters/gebaeude/sammler/Hloz/h2.png"),
		"draggable_scene": preload("res://szenen/aBuilding/sammler/holz2.tscn")
	},
	"Holz3": {
		"texture": preload("res://assets/characters/gebaeude/sammler/Hloz/h3.png"),
		"draggable_scene": preload("res://szenen/aBuilding/sammler/holz3.tscn")
	},
	"Holz4": {
		"texture": preload("res://assets/characters/gebaeude/sammler/Hloz/h4.png"),
		"draggable_scene": preload("res://szenen/aBuilding/sammler/holz4.tscn")
	},
	"Stein1": {
		"texture": preload("res://assets/characters/gebaeude/sammler/Stein/s1.png"),
		"draggable_scene": preload("res://szenen/aBuilding/sammler/holz4.tscn")
	},
	"Stein2": {
		"texture": preload("res://assets/characters/gebaeude/sammler/Stein/s2.png"),
		"draggable_scene": preload("res://szenen/aBuilding/sammler/holz4.tscn")
	},
	"Stein3": {
		"texture": preload("res://assets/characters/gebaeude/sammler/Stein/s3.png"),
		"draggable_scene": preload("res://szenen/aBuilding/sammler/holz4.tscn")
	},
	"Stein4": {
		"texture": preload("res://assets/characters/gebaeude/sammler/Stein/s4.png"),
		"draggable_scene": preload("res://szenen/aBuilding/sammler/holz4.tscn")
	},
	"Metall1": {
		"texture": preload("res://assets/characters/gebaeude/sammler/metall/m1.png"),
		"draggable_scene": preload("res://szenen/aBuilding/sammler/metall1.tscn")
	},
	"Metall2": {
		"texture": preload("res://assets/characters/gebaeude/sammler/metall/m2.png"),
		"draggable_scene": preload("res://szenen/aBuilding/sammler/metall2.tscn")
	},
	"Metall3": {
		"texture": preload("res://assets/characters/gebaeude/sammler/metall/m3.png"),
		"draggable_scene": preload("res://szenen/aBuilding/sammler/metall3.tscn")
	},
	"Metall4": {
		"texture": preload("res://assets/characters/gebaeude/sammler/metall/m4.png"),
		"draggable_scene": preload("res://szenen/aBuilding/sammler/metall4.tscn")
	},
	"Amethyst1": {
		"texture": preload("res://assets/characters/gebaeude/sammler/Amethyst/a1.png"),
		"draggable_scene": preload("res://szenen/aBuilding/sammler/amethyst1.tscn")
	},
	"Amethyst2": {
		"texture": preload("res://assets/characters/gebaeude/sammler/Amethyst/a2.png"),
		"draggable_scene": preload("res://szenen/aBuilding/sammler/amethyst2.tscn")
	},
	"Amethyst3": {
		"texture": preload("res://assets/characters/gebaeude/sammler/Amethyst/a3.png"),
		"draggable_scene": preload("res://szenen/aBuilding/sammler/amethyst3.tscn")
	},
	"Amethyst4": {
		"texture": preload("res://assets/characters/gebaeude/sammler/Amethyst/a4.png"),
		"draggable_scene": preload("res://szenen/aBuilding/sammler/amethyst4.tscn")
	}
}
