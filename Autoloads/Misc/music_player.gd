class_name MusicPlayer
extends AudioStreamPlayer



func _ready():
	loop()


func play_sound(sound : AudioStream):
	#loads stream into audio player and plays sound effect
	stream = sound
	play()
	
	#wait until finished to see if need to loop
	await self.finished
	
	#loops if necessary
	play()


func stop_playing():
	stop()


func loop():
	self.finished.connect(play)
