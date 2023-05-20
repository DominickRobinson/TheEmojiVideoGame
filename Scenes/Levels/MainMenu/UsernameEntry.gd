extends LineEdit


func _on_text_changed(new_text):
	PlayerManager.main_player_name = new_text
#	print("New username: ", new_text)
