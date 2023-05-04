extends Control



@onready var pause_button = $PauseButton
@onready var pause_menu = $PauseMenu

@onready var googly_button = $PauseMenu/PanelContainer/CenterContainer/VBoxContainer/VBoxContainer2/GooglyEyeButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pause_menu.visible = false
	
	googly_button.toggled.connect(PlayerManager.set_googly_eyes)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pause_button_pressed():
	pause_menu.visible = not pause_menu.visible


func _on_resume_button_pressed():
	pause_menu.visible = false
