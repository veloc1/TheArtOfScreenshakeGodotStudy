extends KinematicBody2D

export (int) var run_speed = 50
export (int) var gravity = 1200

var velocity = Vector2()

onready var sprite: AnimatedSprite = $AnimatedSprite
onready var attack_area_x
onready var player: Node2D


func _ready():
	for c in get_parent().get_children():
		if c.is_in_group("player"):
			player = c
	attack_area_x = $attack_area.position.x


func _process(_delta):
	sprite.play("walk")
	if player.position.x < position.x:
		velocity.x = -run_speed
		sprite.flip_h = true
		$attack_area.position.x = -attack_area_x
	else:
		velocity.x = run_speed
		sprite.flip_h = false
		$attack_area.position.x = attack_area_x


func _physics_process(delta):
	velocity.y += gravity * delta

	velocity = move_and_slide(velocity, Vector2(0, -1))


func _on_attack_area_body_entered(body):
	if body.is_in_group("player"):
		body.attacked(self)
