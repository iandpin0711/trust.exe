extends Area2D


func _on_body_entered(body):
	if body is CharacterBody2D:
		body.in_zone = true

func _on_body_exited(body):
	if body is CharacterBody2D:
		body.in_zone = false
