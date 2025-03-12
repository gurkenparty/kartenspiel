extends Node

const PORT = 12345  # You can change this to any open port

func create_server():
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	multiplayer.multiplayer_peer = peer
	print_debug("Server started on port ", PORT)

func join_server(ip_address: String):
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(ip_address, PORT)
	multiplayer.multiplayer_peer = peer
	print_debug("Connected to server at ", ip_address)

func _ready():
	multiplayer.peer_connected.connect(_on_player_connected)

func _on_player_connected(id):
	print_debug("Player connected: ", id)
