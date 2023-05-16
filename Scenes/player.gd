class_name Player
extends RigidBody2D


@export var slow_angular_velocity_boost = 1.0
@export var slow_linear_velocity_boost = 8.0
@export var jump_boost = 600
@export var max_linear_velocity = 1500
@export var max_angular_velocity = 50

@export var current_equipment : Equipment

@onready var googly_eyes = $GooglyEyes
@onready var tag = $NameTag
@onready var ground_raycast = $OnGround
@onready var anim = $AnimationPlayer

var all_equipment : Array[Equipment]

var googly_eyes_mode = PlayerManager.googly_mode : 
	set(value):
		$GooglyEyes.visible = value
var perspective_mode = false
var tag_visible = true :
	set(value):
		tag.visible = value
	get:
		return tag.visible


# Called when the node enters the scene tree for the first time.
func _ready():
	googly_eyes_mode = PlayerManager.googly_mode
	for child in get_children():
		if child is Equipment:
			all_equipment.append(child)
			child.toggle(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if Input.is_action_pressed("ui_right"):
		angular_velocity += slow_angular_velocity_boost
		linear_velocity.x += slow_linear_velocity_boost
	if Input.is_action_pressed("ui_left"):
		angular_velocity -= slow_angular_velocity_boost
		linear_velocity.x -= slow_linear_velocity_boost
	if Input.is_action_just_pressed("ui_accept") and ground_raycast.is_colliding():
		linear_velocity += Vector2(0, -jump_boost)
	if Input.is_action_just_pressed("ui_down"):
		for child in all_equipment:
			if child == current_equipment:
				child.toggle()
			else:
				child.toggle(false)
	
	clamp_linear_velocity(max_linear_velocity)
	clamp_angular_velocity(max_angular_velocity)
	
	set_animation()


func set_animation():

	var av = abs(angular_velocity)
	
	if av > 15:
		anim.play("spin_slow")
	else:
		anim.play("neutral")
	if av > 30:
		anim.play("spin_fast")
	
	if not ground_raycast.is_colliding() and linear_velocity.y > 600:
		anim.play("fall")
	
	if is_instance_valid(current_equipment) and current_equipment.active:
		anim.play(current_equipment.animation_name)
	
	if Input.is_action_pressed("e"):
		anim.play("laugh_cry_meme")


func clamp_linear_velocity(max_lv):
	var curr_lv = linear_velocity.length()
	var new_lv = min(curr_lv, max_lv)
	linear_velocity = linear_velocity.normalized() * new_lv

func clamp_angular_velocity(max_av):
	angular_velocity = min(angular_velocity, max_av)
