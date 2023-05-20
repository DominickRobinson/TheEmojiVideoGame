class_name Equipment
extends CollisionPolygon2D

#@onready var pointer = $Pointer

@export var animation_name = "attack"
@export_file var icon_file = "res://icon.svg"

var active = false

var parent : RigidBody2D = get_parent()

func _ready():
	toggle(false)
	parent = get_parent()

func toggle(value = not active):
	active = value
	visible = value
	disabled = not value
