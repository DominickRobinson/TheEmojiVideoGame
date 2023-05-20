extends Node


var level_paths = {
	"lobby" : "res://Scenes/Levels/lobby.tscn",
	"main_menu" : "res://Scenes/Levels/MainMenu/main_menu.tscn",
	"test_stage" : "res://Scenes/Levels/test_stage.tscn"}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func load_level(level_name):
	var level_path = level_paths[level_name]
	get_tree().change_scene_to_file(level_path)
