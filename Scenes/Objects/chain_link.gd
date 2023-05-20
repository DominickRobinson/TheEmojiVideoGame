extends RigidBody2D

@onready var pinjoint = $PinJoint2D

@export var node_a : PhysicsBody2D
@export var node_b : PhysicsBody2D

func _ready():
	if is_instance_valid(pinjoint):
		if is_instance_valid(node_a): pinjoint.node_a = node_a.get_path()
		if is_instance_valid(node_b): pinjoint.node_b = node_b.get_path()
