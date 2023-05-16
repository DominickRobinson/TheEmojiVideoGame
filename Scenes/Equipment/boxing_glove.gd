extends Equipment

@export var punch_force : float = 1500

@onready var anim = $AnimationPlayer
@export var hurtbox : Area2D

@export var punching = false

# Called when the node enters the scene tree for the first time.
func _ready():
	punching = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	hurtbox.monitoring = punching
#	if punching:
#		for body in hurtbox.get_overlapping_bodies():
#			if not is_instance_valid(body) or not (body is RigidBody2D) or body == parent:
#				continue
#			body = body as RigidBody2D
#			if punching:
#				punch_body(body)
	pass


func toggle(value = not visible):
	if active:
		return
	super.toggle(value)
	if value:
		punch()
	
	await anim.animation_finished
	super.toggle(false)


func punch():
	anim.play("punch")


func punch_body(body):
	var direction = (global_position - body.global_position).normalized()
	var punch_impulse = direction * punch_force
#	body.apply_central_force(punch_impulse)
	if body is RigidBody2D:
		body.linear_velocity = direction * punch_force
	if is_instance_valid(parent):
#		parent.apply_central_force(-punch_impulse)
		parent.linear_velocity = -direction * punch_force



func _on_punch_hurtbox_body_entered(body):
	if not punching:
		return
	if not is_instance_valid(body) or not (body is RigidBody2D or body is TileMap) or body == parent:
		return
	
	if punching:
		punch_body(body)
