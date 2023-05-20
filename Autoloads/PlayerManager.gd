extends Node

const PlayerResource = preload("res://Scenes/player.tscn")

var players : Array[Player]

#settings
var camera_zoom = 1 : 
	set(value):
		set_camera_zoom(value)
#modes
var googly_eye_mode = false :
	set(value):
		set_googly_eye_mode(value)
	get:
		return googly_eye_mode
var perspective_mode = false :
	set(value):
		set_perspective_mode(value)
	get:
		return perspective_mode
var stable_sprite_mode = false :
	set(value):
		set_stable_sprite_mode(value)
var name_tags_visible_mode = true :
	set(value):
		set_name_tags_visible_mode(value)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func get_all_players():
	players.clear()
	get_player_children(get_tree().get_root())
#	print(players)


func get_player_children(node = self):
	var children = node.get_children()
	for c in children:
		if is_instance_valid(c):
			if c is Player:
				players.append(c)
			get_player_children(c)


func set_googly_eye_mode(googly_on := true):
	get_all_players()
	for p in players:
		p = p as Player
		p.googly_eyes_mode = googly_on

func set_perspective_mode(perspective_on := true):
	get_all_players()
	for p in players:
		p = p as Player
		p.perspective_mode = perspective_on

func set_stable_sprite_mode(stable_sprite_on := true):
	get_all_players()
	for p in players:
		p = p as Player
		p.stable_sprite_mode = stable_sprite_on

func set_name_tags_visible_mode(name_tag_visible := true):
	get_all_players()
	for p in players:
		p = p as Player
		p.name_tag_visible_mode = name_tag_visible

func set_camera_zoom(zoom):
	get_all_players()
	for p in players:
		p = p as Player
		p.camera_zoom = zoom


func add_player(peer_id):
	var new_player = PlayerResource.instantiate()
	new_player.peer_id = str(peer_id)
	get_tree().current_scene.add_child(new_player, true)
	new_player.username = str(peer_id)
	return new_player
