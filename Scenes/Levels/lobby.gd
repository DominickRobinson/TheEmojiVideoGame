extends Node

const PlayerResource = preload("res://Scenes/player.tscn")

@onready var lobby = $Lobby
@onready var multiplayer_menu = $CenterContainer
@onready var address_entry = $CenterContainer/MultiplayerMenuContainer/CenterContainer/MarginContainer/VBoxContainer/AddressEntry

const PORT = 9999
var enet_peer = ENetMultiplayerPeer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_host_button_pressed():
	multiplayer_menu.hide()
	lobby.show()
	
	enet_peer.create_server(PORT)
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.peer_connected.connect(add_player)
	
	add_player(multiplayer.get_unique_id())


func _on_join_button_pressed():
	multiplayer_menu.hide()
	lobby.show()
	
	enet_peer.create_client("localhost", PORT)
	multiplayer.multiplayer_peer = enet_peer


func add_player(peer_id):
	var new_player = PlayerResource.instantiate()
	new_player.name = str(peer_id)
	add_child(new_player)
