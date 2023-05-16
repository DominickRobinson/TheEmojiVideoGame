extends Sprite2D


var stable_sprite_mode = PlayerManager.stable_sprite_mode

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if stable_sprite_mode:
		global_rotation_degrees = 0
	else:
		rotation_degrees = 0
