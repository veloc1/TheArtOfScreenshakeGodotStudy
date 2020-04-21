extends KinematicBody2D

onready var movement = $movement

func _physics_process(_delta):
	var action_right = Input.is_action_pressed('ui_right')
	var action_left = Input.is_action_pressed('ui_left')
	var action_jump = Input.is_action_pressed('action1')
	var action_shoot = Input.is_action_pressed('action2')

	if action_jump and movement.can_jump():
		movement.jump()

	if action_right:
		movement.move_right()
	elif action_left:
		movement.move_left()
	else:
		movement.still()

	if not movement.is_active():
		movement.idle()
		# if action_jump:
			# assert(false)

	if action_shoot:
		pass
		# shoot()

# export (int) var run_speed = 200
# export (int) var jump_speed = -450
# export (int) var gravity = 1200
# export (Vector2) var default_impact = Vector2(300, -200)

# var Bullet = preload("res://src/objects/bullet.tscn")

# var velocity = Vector2()
# var jumping = false
# var impact_force = Vector2()

# onready var sprite: AnimatedSprite = $AnimatedSprite
# onready var shoot_timer: Timer = $shoot_timer
# onready var bullet_spawn: Node2D = $bullet_spawn


# func process_input():
# 	velocity.x = 0
# 	var right = Input.is_action_pressed('ui_right')
# 	var left = Input.is_action_pressed('ui_left')
# 	var jump = Input.is_action_just_pressed('action1')
# 	var shoot = Input.is_action_pressed('action2')
# 	var anim = 'idle'

# 	if jump and (is_on_floor() or $ghost_jump_timer.time_left > 0):
# 		jumping = true
# 		velocity.y = jump_speed
# 		$ghost_jump_timer.stop()

# 	if right:
# 		velocity.x += run_speed
# 		sprite.flip_h = false

# 		if bullet_spawn.position.x < 0:
# 			bullet_spawn.position.x = -bullet_spawn.position.x

# 		anim = 'run'
# 	if left:
# 		velocity.x -= run_speed
# 		sprite.flip_h = true

# 		if bullet_spawn.position.x > 0:
# 			bullet_spawn.position.x = -bullet_spawn.position.x

# 		anim = 'run'

# 	if jumping:
# 		anim = 'jump'

# 	sprite.play(anim)

# 	if shoot:
# 		shoot()


# func _physics_process(delta):
# 	process_input()
# 	velocity.y += gravity * delta

# 	if impact_force.x != 0:
# 		velocity += impact_force
# 		impact_force.x = lerp(impact_force.x, 0, 0.1)
# 		impact_force.y = 0

# 	velocity = move_and_slide(velocity, Vector2(0, -1))

# 	if jumping and is_on_floor():
# 		jumping = false

# 	if is_on_floor():
# 		$ghost_jump_timer.start()


# func shoot():
# 	if shoot_timer.time_left > 0:
# 		return
# 	shoot_timer.start()
# 	var bullet: Area2D = Bullet.instance()
# 	get_parent().add_child(bullet)
# 	bullet.position = Vector2(bullet_spawn.global_position.x, bullet_spawn.global_position.y)
# 	bullet.set_direction(bullet_spawn.position.x > 0)


# func attacked(from):
# 	impact_force.y = default_impact.y
# 	if from.position.x > position.x:
# 		impact_force.x = -default_impact.x
# 	elif from.position.x < position.x:
# 		impact_force.x = default_impact.x
