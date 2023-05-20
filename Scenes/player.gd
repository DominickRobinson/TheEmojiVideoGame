class_name Player
extends RigidBody2D


@export var username = "" :
	set(value):
		if is_instance_valid(name_tag): 
			username = value
			name_tag.text = value

@export var ground_linear_velocity_boost = 20.0
@export var aerial_linear_velocity_boost = 12.0

@export var ground_angular_velocity_boost = 0.5
@export var aerial_angular_velocity_boost = 0.35

@export var ground_jump_boost = 600
@export var wall_jump_boost = 650
@export var wall_jump_angle_degrees = 70

@export var min_linear_velocity = 0
@export var min_angular_velocity = 0
@export var max_linear_velocity = 1500
@export var max_angular_velocity = 50


@export var current_equipment : Equipment :
	set(value):
		current_equipment = value
		set_equipment_icon()
@export var equipment_display : TextureRect


@onready var googly_eyes = $Sprite2D/GooglyEyes
@onready var name_tag = $NameTag
@onready var camera = $Camera2D
@onready var ground_raycast = $OnGround
@onready var left_raycast = $OnLeftWall
@onready var right_raycast = $OnRightWall
@onready var sprite = $Sprite2D
@onready var anim = $AnimationPlayer
@onready var pointer = $Pointer


var peer_id

#settings
var camera_zoom : float = 1.0 :
	set(value): 
		if is_instance_valid(camera): 
			camera.zoom = Vector2(1,1) * value
#modes
var googly_eyes_mode = PlayerManager.googly_eye_mode : 
	set(value):
		for eye in googly_eyes.get_children():
			eye.visible = value
var perspective_mode = PlayerManager.perspective_mode : 
	set(value):
		if is_instance_valid(camera): camera.ignore_rotation = not value
var stable_sprite_mode = PlayerManager.stable_sprite_mode :
	set(value):
		sprite.stable_sprite_mode = value
var name_tag_visible_mode = true :
	set(value):
		if is_instance_valid(name_tag): name_tag.visible = value
	get:
		return name_tag.visible


# Called when the node enters the scene tree for the first time.
func _ready():
	googly_eyes_mode = PlayerManager.googly_eye_mode
	
	if is_instance_valid(name_tag):
		name_tag.text = username
	
	if current_equipment == null:
		for e in get_children():
			if e is Equipment: 
				current_equipment = e
				break


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	var lv_boost = aerial_linear_velocity_boost
	var av_boost = aerial_angular_velocity_boost
	if grounded():
		lv_boost = ground_linear_velocity_boost
		av_boost = ground_angular_velocity_boost
	
	#movement handler
	#move right
	if Input.is_action_pressed("ui_right"):
		if angular_velocity < 0: angular_velocity = min_angular_velocity
		angular_velocity += av_boost
		linear_velocity.x += lv_boost
	#move left
	if Input.is_action_pressed("ui_left"):
		if angular_velocity > 0: angular_velocity = -min_angular_velocity
		angular_velocity -= av_boost
		linear_velocity.x -= lv_boost
	#jump
	if Input.is_action_just_pressed("jump"):
		if grounded():
			linear_velocity.y -= ground_jump_boost
		elif on_left_wall():
			linear_velocity = Vector2.RIGHT.rotated(deg_to_rad(-wall_jump_angle_degrees)) * wall_jump_boost
		elif on_right_wall():
			linear_velocity = Vector2.LEFT.rotated(deg_to_rad(wall_jump_angle_degrees)) * wall_jump_boost
	#use equipment
	if Input.is_action_just_pressed("ui_down"):
		current_equipment.toggle()
	
	
	clamp_linear_velocity(max_linear_velocity)
	clamp_angular_velocity(max_angular_velocity)
	
	set_animation()


func _process(delta):
	pointer.visible = not current_equipment.active


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


func grounded():
	return ground_raycast.is_colliding()


func on_left_wall():
	return left_raycast.can_jump()


func on_right_wall():
	return right_raycast.can_jump()


func set_equipment_icon():
	if is_instance_valid(current_equipment):
		equipment_display.set_icon(current_equipment.icon_file)
