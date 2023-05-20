extends HBoxContainer


@onready var label = $Label
@onready var line_edit = $LineEdit

@export var property : String

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = property
	player = get_parent().player as Player
	
	if property in player:
		line_edit.text = str(get_property())


func _on_line_edit_text_submitted(new_text):
	set_property(new_text)
	
	if property in player:
		line_edit.text = str(get_property())
	
	line_edit.release_focus()


func set_property(value):
	if property in player:
		player.set(property, float(value))

func get_property():
	var value = null
	if property in player:
		value = player.get(property)
	return value
