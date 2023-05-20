class_name Ball
extends RigidBody2D

@export var collision_shape : Node2D

@export var grabbable := true

var target = null

var grabbed = false:
	set(value):
		grabbed = value
		if is_instance_valid(collision_shape):
			collision_shape.disabled = grabbed
#		freeze = value
		custom_integrator = value
var desired_gp : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	custom_integrator = false

func _integrate_forces(_state):
	if not grabbed:
		return
	if target == null:
		global_position = desired_gp
	else:
		global_position = target.global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func snap_global_position(new_gp):
	custom_integrator = true
	desired_gp = new_gp
	
	await get_tree().physics_frame
	await get_tree().physics_frame
	await get_tree().physics_frame
	custom_integrator = false
