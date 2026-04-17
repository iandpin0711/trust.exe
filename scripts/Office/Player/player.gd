extends CharacterBody2D

const SPEED = 300.0
var in_zone = false

func _physics_process(delta):
	var direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	)

	if direction != Vector2.ZERO:
		velocity = direction.normalized() * SPEED
		if direction.x < 0:
			$AnimatedSprite2D.play("right")
		elif direction.x > 0:
			$AnimatedSprite2D.play("left")
		elif direction.y < 0:
			$AnimatedSprite2D.play("back")
		elif direction.y > 0:
			$AnimatedSprite2D.play("front")
	else:
		velocity = Vector2.ZERO
		$AnimatedSprite2D.play("idle")
		
	move_and_slide()
func _input(event):
	if event.is_action_pressed("interact") and in_zone:
		get_tree().change_scene_to_file("res://scenes/Computer/WindowsLoading.tscn")
