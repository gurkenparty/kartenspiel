extends Control
@export var player_number:int = 1
@export var label_username: Label
@export var label_hp: Label
@export var GameState:Node3D
@export var character_wallpaper:Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if self.name == "Basis":
		label_username.text = GameStats.username
		character_wallpaper.texture = GameStats.avatar
	elif self.name == "Basis2":
		label_username.text = "Bot Trainer"
		character_wallpaper.texture = load("res://assets/wallpapers/wallpaper_skelleton_warrior.png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if self.name == "Basis":
		label_hp.text = str(GameStateWorld.player_1_hp)
	elif self.name == "Basis2":
		label_hp.text = str(GameStateWorld.player_2_hp)
		
func change_hp_base(value:int):
	print_debug("calling in change hp bade player number is: " + str(player_number))
	GameStateWorld.player_2_hp += value
	label_hp.text = str(GameStateWorld.player_2_hp)
	if GameStateWorld.player_2_hp <= 0 and self.visible:
		self.visible = false
