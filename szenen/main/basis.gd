extends Control
@export var player_number:int
@export var label_username: Label
@export var label_hp: Label
@export var GameState:Node3D
@export var character_wallpaper:Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	player_number = GameState.player_number
	if player_number == GameStateWorld.current_player:
		self.visible = true
		
	else:
		self.visible = false
		
	if visible:
		if player_number == 1 and self.name == "Basis":
			label_username.text = GameStateWorld.player_1_username
			character_wallpaper.texture = GameStateWorld.player_1_avatar
		elif player_number == 1 and self.name == "Basis2":
			label_username.text = GameStateWorld.player_2_username
			character_wallpaper.texture = GameStateWorld.player_2_avatar
		elif player_number == 2 and self.name == "Basis":
			label_username.text = GameStateWorld.player_2_username
			character_wallpaper.texture = GameStateWorld.player_2_avatar
		elif player_number == 2 and self.name == "Basis2":
			label_username.text = GameStateWorld.player_1_username
			character_wallpaper.texture = GameStateWorld.player_1_avatar
func change_hp_base(value:int):
	print_debug("calling in change hp bade player number is: " + str(player_number))
	GameStateWorld.player_2_hp += value
	label_hp.text = str(GameStateWorld.player_2_hp)
	if GameStateWorld.player_2_hp <= 0 and self.visible:
		self.visible = false
