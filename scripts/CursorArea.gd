extends Area2D

var hover: String = "select"
var idle: String = "idle"

@export var target_scene: PackedScene

@onready var cursor = get_tree().get_first_node_in_group("Cursor")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Cursor"):
		body.change_cursor_appearance(hover)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Cursor"):
		body.change_cursor_appearance(idle)

func change_to_scene():
	if target_scene:
		get_tree().change_scene_to_packed(target_scene)
