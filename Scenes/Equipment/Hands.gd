extends Equipment


@export var active_seconds := 3.0
@export var cooldown_seconds := 2.0


@export var pinjoint : PinJoint2D
@onready var anim = $AnimationPlayer

var grabbing = false :
	set(value):
		if value: anim.play("full")
		else: anim.play("empty")
var cooling_down = false

func _ready():
	pinjoint.node_a = parent.get_path()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	pass


func _on_area_2d_body_entered(body):
	print("attempted grab")
	if cooling_down or not is_instance_valid(body) or not(body is Ball) or not active:
		return
	print("successful grab")
	body = body as Ball
#	body.set_target(pinjoint)
	pinjoint.node_b = body.get_path()
	grabbing = true
	modulate = Color.WHITE
	
	await get_tree().create_timer(active_seconds).timeout	
	release()


func toggle(value = not visible):
	super.toggle(value)
	if not value:
		release()


func release():
	print("release grab")
	pinjoint.node_b = ""
	grabbing = false
	cooling_down = true
	modulate = Color.DIM_GRAY
	
	await get_tree().create_timer(cooldown_seconds).timeout
	print("grab cooled down")
	cooling_down = false
	modulate = Color.WHITE

