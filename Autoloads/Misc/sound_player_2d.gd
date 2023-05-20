class_name SoundPlayer2D
extends AudioStreamPlayer2D


var node_following



func _physics_process(_delta):
	if node_following != null:
		global_position = node_following.global_position


func start_following(node):
	node_following = node


func stop_following():
	node_following = null


func play_sound(sound : AudioStream, loop := false):
	#loads stream into audio player and plays sound effect
	stream = sound
	play()
	
	#wait until finished to see if need to loop
	await self.finished
	
	#loops if necessary
	if loop:
		play()
	
	#returns self in case whoever called this needs to know which sound effect player
	return self


func stop_playing():
	stop()
