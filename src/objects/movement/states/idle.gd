extends State
class_name IdleState

export (int) var gravity = 1200

onready var ghost_jump_timer

func _ready():
	ghost_jump_timer = Timer.new()
	ghost_jump_timer.wait_time = 0.2
	add_child(ghost_jump_timer)

func can_jump():
	return body.is_on_floor() or ghost_jump_timer.time_left > 0

func jump():
	change_state("jump")

func move_left():
	look_left()
	change_state("walk")

func move_right():
	look_right()
	change_state("walk")

func still():
	set_velocity(0, get_velocity().y)

func _physics_process(_delta):
	if body.is_on_floor():
		ghost_jump_timer.start()

func get_animation_name():
	return "idle"
