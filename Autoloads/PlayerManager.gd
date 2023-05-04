extends Node


var players : Array[Player]

var googly_mode = false


# Called when the node enters the scene tree for the first time.
func _ready():
	get_all_players()


func get_all_players():
	players.clear()
	get_player_children(get_tree().get_root())
	print(players)


func get_player_children(node = self):
	var children = node.get_children()
	for c in children:
		if is_instance_valid(c):
			if c is Player:
				players.append(c)
			get_player_children(c)
	

func set_googly_eyes(googly_on := true):
	get_all_players()
	for p in players:
		p = p as Player
		p.googly_eyes_mode = googly_on
