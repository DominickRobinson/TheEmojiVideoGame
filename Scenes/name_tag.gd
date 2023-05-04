@tool
extends Node2D

@export var text : String = "*name"
@export var offset : Vector2 = Vector2(0,0)

@onready var parent = get_parent()
@onready var label = $Label

func _ready():
	label.text = text
	visible = true
	

func _process(delta):
	global_position = parent.global_position + offset
	global_rotation = 0
