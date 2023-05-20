extends Node2D

@export var text : String = "*name":
	set(value):
		label.text = value
@export var offset : Vector2 = Vector2(0,-48)
@export var color : Color = Color(1,1,1)

@export var target : Node2D

@onready var label = $Label

func _ready():
	if target == null:
		queue_free()
	label.text = text
	visible = PlayerManager.name_tags_visible_mode

func _physics_process(_delta):
	global_position = target.global_position + offset
	global_rotation = 0
