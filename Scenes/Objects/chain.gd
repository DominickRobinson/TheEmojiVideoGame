extends Node2D

@export var node_a : PhysicsBody2D
@export var node_b : PhysicsBody2D

var start_joint = PinJoint2D.new()
var end_joint = PinJoint2D.new()

var chain_link_resource = preload("res://Scenes/Objects/chain_link.tscn")

var link_offset = 42


func _ready():
	var start_link
	var end_link
	var prev_link
	
	var displacement = (node_b.global_position - node_a.global_position)
	
	var links_needed = displacement.length() / 42
	links_needed = ceil(links_needed)
	
	var angle_of_chain = displacement.angle()
	
	
	for i in links_needed+1:
		#create new chain link
		var new_link = chain_link_resource.instantiate() as RigidBody2D
		new_link.rotation = angle_of_chain
		
		#set correct position of new chain link
		if is_instance_valid(prev_link):
			new_link.position = prev_link.position + Vector2(link_offset, 0).rotated(angle_of_chain)
		else:
			new_link.position = Vector2.ZERO
		
		#build chain
		if i == 0:
			start_link = new_link
			new_link.node_b = new_link
		elif i == links_needed:
			end_link = new_link
			new_link.node_a = prev_link
			new_link.node_b = new_link
		else:
			new_link.node_a = prev_link
			new_link.node_b = new_link
		add_child(new_link)
		prev_link = new_link
	
	start_joint.node_a = node_a.get_path()
	start_joint.node_b = start_link.get_path()
	start_link.add_child(start_joint)
	
	end_joint.node_a = end_link.get_path()
	end_joint.node_b = node_b.get_path()
	end_link.add_child(end_joint)
	end_link.hide()
