extends RigidBody2D


@onready var sword = $Sword

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if Input.is_action_pressed("ui_right"):
		angular_velocity += 1.5
	if Input.is_action_pressed("ui_left"):
		angular_velocity -= 1.5
	if Input.is_action_just_pressed("ui_accept"):
		linear_velocity += Vector2(0, -600)
	if Input.is_action_just_pressed("ui_down"):
		sword.visible = not sword.visible
		sword.disabled = not sword.disabled
