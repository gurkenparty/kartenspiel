extends Node
var player_1_cam : Camera3D
var player_2_cam :Camera3D
var player_1_username:String = "Sean"
var player_2_username:String = "Max ist Gay"
var player_1_avatar:Texture2D = preload("res://assets/wallpapers/wallpaper_dragon.png")
var player_2_avatar:Texture2D = preload("res://assets/wallpapers/wallpaper_magic_queen.png")
var player_1_hp:int = 100
var player_2_hp:int = 100


enum Phase { 
	FIRST_EFFECT, 
	DRAWING, 
	PLAYING, 
	FIGHTING, 
	LAST_EFFECT 
}

var current_phase: int = Phase.FIRST_EFFECT
var current_player: int = 1  # 1 for Player 1, 2 for Player 2
var max_players: int = 2  # Supports more players if needed

signal phase_changed(new_phase)
signal turn_changed(new_player)
func next_phase():
	current_phase += 1
	print_debug("Next phase triggered: " + str(current_phase))  

	if current_phase > Phase.LAST_EFFECT:
		end_turn()
	else:
		phase_changed.emit(current_phase)  
		print_debug("Phase changed signal emitted: " + str(current_phase))

func end_turn():
	current_phase = Phase.FIRST_EFFECT
	current_player += 1
	print_debug("End turn triggered. Current player: " + str(current_player))  

	if current_player > max_players:
		current_player = 1  # Loop back to Player 1
	turn_changed.emit(current_player)
	print_debug("Turn changed signal emitted: " + str(current_player))

		

	phase_changed.emit(current_phase)  
	print_debug("Phase changed signal emitted (end turn): " + str(current_phase))  


		
func get_phase_name() -> String:
	match current_phase:
		Phase.FIRST_EFFECT: return "Mein Zug"
		Phase.DRAWING: return "Karte ziehen"
		Phase.PLAYING: return "Spielen"
		Phase.FIGHTING: return "Kämpfen"
		Phase.LAST_EFFECT: return "Zug beenden"
		_: return "Unknown Phase"
		

	
