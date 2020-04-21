extends Node2D
class_name Movement

const BIT_IDLE = 0b00000001
const BIT_WALK = 0b00000010
const BIT_JUMP = 0b00000100

export(NodePath) var animated_sprite
export(NodePath) var kinematic_body

export (int) var gravity = 1200

export (int, FLAGS, "Has Idle State", "Has Walk State", "Has Jump State") var states_flags = 0

var states = {}
var current_state: State = null
var velocity = Vector2(0, 0)

func _ready():
	if states_flags & BIT_IDLE:
		states["idle"]=  IdleState
	if states_flags & BIT_WALK:
		states["walk"] = WalkState
	if states_flags & BIT_JUMP:
		states["jump"]= JumpState

	set_state("idle")

func set_state(name):
	# print("Set state to " + name)

	if current_state != null:
		current_state.queue_free()

	if name in states:
		current_state = states[name].new()

		var spr = get_node(animated_sprite)
		var b = get_node(kinematic_body)
		current_state.setup(self, spr, b)

		current_state.name = name

		current_state.set_active(true)

		add_child(current_state)
	else:
		var m = "Cannot find state %s" % name
		print(m)
		push_warning(m)
		current_state = null

func _physics_process(delta):
	var b = get_node(kinematic_body)

	velocity.y += gravity * delta
	velocity = b.move_and_slide(velocity, Vector2.UP)
	# set_velocity(get_velocity().x, get_velocity().y + gravity * delta)

	# var new_velocity = body.move_and_slide(get_velocity(), Vector2.UP)
	# set_velocity_vec(new_velocity)

func can_jump():
	return current_state.can_jump()

func jump():
	current_state.jump()

func move_left():
	current_state.move_left()

func move_right():
	current_state.move_right()

func still():
	current_state.still()

func idle():
	if current_state.name != "idle":
		set_state("idle")

func is_active():
	return current_state.is_active()

func reset_active():
	current_state.set_active(false)

func set_velocity(new_velocity):
	velocity = new_velocity

func get_velocity():
	return velocity
