extends Control


@export var pause_menu : Control
#pause control buttons
@export_group("Pause control buttons")
@export var pause_button : Button
@export var main_menu_button : Button
#options buttons
@export_group("Options buttons")
@export var name_tags_visible_button : Button
@export var camera_zoom_slider : HSlider
@export var googly_button : Button
@export var perspective_button : Button
@export var stable_sprite_button : Button



# Called when the node enters the scene tree for the first time.
func _ready():
	pause_menu.visible = false
	
	#connect buttons
	name_tags_visible_button.toggled.connect(PlayerManager.set_name_tags_visible_mode)
	googly_button.toggled.connect(PlayerManager.set_googly_eye_mode)
	perspective_button.toggled.connect(PlayerManager.set_perspective_mode)
	stable_sprite_button.toggled.connect(PlayerManager.set_stable_sprite_mode)
	
	name_tags_visible_button.button_pressed = PlayerManager.name_tags_visible_mode
	googly_button.button_pressed = PlayerManager.googly_eye_mode
	perspective_button.button_pressed = PlayerManager.perspective_mode
	stable_sprite_button.button_pressed = PlayerManager.stable_sprite_mode
	
#	camera_zoom_slider.drag_ended.connect(PlayerManager.set_camera_zoom, camera_zoom_slider.value)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	PlayerManager.camera_zoom = camera_zoom_slider.value


func _on_pause_button_pressed():
	pause_menu.visible = not pause_menu.visible


func _on_resume_button_pressed():
	pause_menu.visible = false


func _on_main_menu_button_pressed():
	LevelManager.load_level("main_menu")
