extends Button

@export var level_name := ""

func _ready():
	self.pressed.connect(load_level)


func load_level():
	LevelManager.load_level(level_name)
#	MultiplayerManager.host_game()
