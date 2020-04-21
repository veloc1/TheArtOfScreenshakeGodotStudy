extends Area2D

var speed = Vector2(500, 0)
var direction = Vector2(1, 0)


func _process(delta):
	position = position + (speed * direction * delta)


func set_direction(is_right):
	if is_right:
		direction.x = 1
	else:
		direction.x = -1
		$Sprite.flip_h = true


func _on_bullet_body_entered(body):
	if body.is_in_group("player"):
		# do not collide with player
		return
	queue_free()
