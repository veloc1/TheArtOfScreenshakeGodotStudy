extends IdleState
class_name WalkState

export (int) var run_speed = 200

func move_left():
	look_left()
	set_velocity(-run_speed, get_velocity().y)
	set_active(true)

func move_right():
	look_right()
	set_velocity(run_speed, get_velocity().y)
	set_active(true)

func still():
	set_active(false)

func get_animation_name():
	return "walk"
