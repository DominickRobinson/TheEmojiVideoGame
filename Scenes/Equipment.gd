class_name Equipment
extends CollisionPolygon2D


var active = false
@export var animation_name = "attack"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func toggle(value = not visible):
	active = value
	visible = active
	disabled = not active
