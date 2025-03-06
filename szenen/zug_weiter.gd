extends Button
@export var option_btn: Button
func _ready():
	text = GameStateWorld.get_phase_name()
	GameStateWorld.phase_changed.connect(_on_phase_changed)
	GameStateWorld.turn_changed.connect(_on_turn_changed)
	connect("pressed", _on_pressed)

func _on_pressed():
	GameStateWorld.next_phase()

func _on_phase_changed(new_phase):
	text = GameStateWorld.get_phase_name()

func _on_turn_changed(new_player):
	print("Player " + str(new_player) + "'s turn!")
