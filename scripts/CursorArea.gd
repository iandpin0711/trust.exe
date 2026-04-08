extends Area2D

var hover: String = "select"
var idle: String = "idle"

@export var target_scene: PackedScene

var is_hovering: bool = false

@onready var cursor = get_tree().get_first_node_in_group("Cursor")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Cursor"):
		is_hovering = true
		body.change_cursor(hover)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Cursor"):
		is_hovering = false
		body.change_cursor(idle)

func _input(event: InputEvent):
	if is_hovering and event.is_action_pressed("click"):
		var cursor = get_tree().get_first_node_in_group("Cursor")
		change_to_scene()

func change_to_scene():
	if target_scene:
		get_tree().change_scene_to_packed(target_scene)
