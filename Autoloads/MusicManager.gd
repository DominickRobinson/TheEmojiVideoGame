extends Node


var MusicPlayerInstance = preload("res://Autoloads/Misc/music_player.tscn")

var music_dictionary = {}
var music_player

func _ready():
	music_player = MusicPlayerInstance.instantiate()
	add_child(music_player)

#plays track
func play_song(song_name : String):
	var song_filepath = music_dictionary[song_name]
	var song = load(song_filepath)
	music_player.play_song(song)
