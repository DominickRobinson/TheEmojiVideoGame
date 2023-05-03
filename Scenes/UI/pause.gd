extends Control



@onready var pause_button = $PauseButton
@onready var pause_menu = $PauseMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	pause_menu.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pause_button_pressed():
	pause_menu.visible = true


func _on_resume_button_pressed():
	pause_menu.visible = false
