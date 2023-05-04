extends PanelContainer


@onready var address_entry = $VBoxContainer/AddressEntry

const Player = preload("res://Scenes/player.tscn")
const PORT = 9999
var enet_peer = ENetMultiplayerPeer.new()

func _on_host_button_pressed():
	enet_peer.create_server(PORT)
	multiplayer.multiplayer_peer = enet_peer

func _on_join_button_pressed():
	pass # Replace with function body.

func add_player(peer_id):
	var player = Player.instantiate()
	player.name = str(peer_id)
