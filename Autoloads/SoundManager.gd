extends Node


var sound_effects_dictionary = {}
var SoundPlayerInstance = preload("res://Autoloads/Misc/sound_player.tscn")
var SoundPlayer2DInstance = preload("res://Autoloads/Misc/sound_player_2d.tscn")
var sound_players : Array[SoundPlayer]
var sound_players_2d : Array[SoundPlayer2D]

var number_of_sound_players = 10
var number_of_sound_players_2d = 10


func _ready():
	#create sound players
	for i in number_of_sound_players:
		var a = SoundPlayerInstance.instantiate()
		add_child(a)
		sound_players.append(a)
	#create 2d sound players
	for i in number_of_sound_players_2d:
		var a = SoundPlayer2DInstance.instantiate()
		add_child(a)
		sound_players_2d.append(a)


#play regular sound
func play_sound(sound_name : String, node):
	var sound_filepath = sound_effects_dictionary[sound_name]
	var sound = load(sound_filepath)
	var sound_player = get_free_sound_player().play_sound(sound)
	return sound_player
#plays 2d sound
func play_sound_2d(sound_name : String, node):
	var sound_filepath = sound_effects_dictionary[sound_name]
	var sound = load(sound_filepath)
	var sound_player_2d = get_free_sound_player_2d().play_sound(sound)
	#because this is 2d sound, we want to follow the node that called this function
	sound_player_2d.set_following(node)
	return sound_player_2d


#finds an unoccupied sound player
func get_free_sound_player():
	for a in sound_players:
		if not a.playing:
			return a
#finds an unoccupied 2d sound player
func get_free_sound_player_2d():
	for a in sound_players_2d:
		if not a.playing:
			return a
