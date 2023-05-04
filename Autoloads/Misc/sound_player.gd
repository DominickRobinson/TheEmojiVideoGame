class_name SoundPlayer
extends AudioStreamPlayer



func play_sound(sound : AudioStream, loop := false):
	
	#loops audio if necessary
	if loop: loop()
	else: unloop()
	
	#loads stream into audio player and plays sound effect
	stream = sound
	play()
	
	#returns self in case whoever called this needs to know which sound effect player
	return self


func stop_playing():
	stop()


func loop():
	self.finished.connect(play)

func unloop():
	self.finished.disconnect(play)
