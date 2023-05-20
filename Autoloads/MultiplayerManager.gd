extends Node



const PORT = 9999
var enet_peer = ENetMultiplayerPeer.new()
var address = "000"


func host_game():
	enet_peer.create_server(PORT)
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.peer_connected.connect(PlayerManager.add_player)
	
	PlayerManager.main_player = PlayerManager.add_player(multiplayer.get_unique_id())



func join_game():
	enet_peer.create_client("localhost", PORT)
	multiplayer.multiplayer_peer = enet_peer



