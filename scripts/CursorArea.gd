extends Area2D
class_name GeneralCursorArea

var hover: String = "select"
var idle: String = "idle"
var loading: String = "loading"

@export var target_scene: PackedScene

var is_hovering: bool = false
var is_loading: bool = false

var loading_time: float = 1

@onready var cursor = get_tree().get_first_node_in_group("Cursor")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Cursor") and not is_loading:
		is_hovering = true
		body.change_cursor(hover)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Cursor") and not is_loading:
		is_hovering = false
		body.change_cursor(idle)

func _input(event: InputEvent):
	if is_hovering and event.is_action_pressed("click") and not is_loading:
		is_loading = true
		change_to_scene()

func change_to_scene():
	if target_scene:
		if cursor:
			cursor.change_cursor(loading)
		await get_tree().create_timer(loading_time).timeout
		get_tree().change_scene_to_packed(target_scene)
