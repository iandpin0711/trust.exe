extends Area2D

@export var hover: String = "select"
@export var idle: String = "idle"

@onready var cursor = get_tree().get_first_node_in_group("Cursor")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Cursor"):
		body.change_cursor_appearance(hover)


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Cursor"):
		body.change_cursor_appearance(idle)
