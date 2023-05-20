extends Equipment


@export var active_seconds := 3.0
@export var cooldown_seconds := 2.0

@export var pinjoint : PinJoint2D
@export var grab_point : StaticBody2D

@onready var anim = $AnimationPlayer

var grabbing = false :
	set(value):
		if value: anim.play("full")
		else: anim.play("empty")
var cooling_down = false

var ball_grabbing : Ball = null


func _on_area_2d_body_entered(body):
	if cooling_down or not is_instance_valid(body) or not(body is Ball) or not active or grabbing:
		return
#	print("successful grab")
	ball_grabbing = body
#	pinjoint.node_b = ball_grabbing.get_path()
	ball_grabbing.grabbed = true
	ball_grabbing.target = grab_point
	grabbing = true
	modulate = Color.WHITE
	
	await get_tree().create_timer(active_seconds).timeout
	release()


func toggle(value = not visible):
	super.toggle(value)
	if not value:
		release(false)


func release(cooldown = true):
#	print("release grab")
	pinjoint.node_b = ""
	grabbing = false
	if is_instance_valid(ball_grabbing):
		ball_grabbing.linear_velocity = get_parent().linear_velocity
		ball_grabbing.grabbed = false
		ball_grabbing.target = null
		ball_grabbing = null
	
	if not cooldown:
		return
	
	cooling_down = true
	modulate = Color.DIM_GRAY
	
	await get_tree().create_timer(cooldown_seconds).timeout
#	print("grab cooled down")
	cooling_down = false
	modulate = Color.WHITE

