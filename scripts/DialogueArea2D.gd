extends Area2D

const DialogueSystemPreload = preload("res://scenes/DialogueSystem.tscn")

@export var activate_instant: bool
@export var only_activate_once: bool
@export var override_dialogue_position: bool
@export var override_position: Vector2
@export var dialogue: Array[DE]

var dialogue_top_pos: Vector2 = Vector2(0, -60) 
var dialogue_bottom_pos: Vector2 = Vector2(0, 65)

var player_body_in = false
var has_activated_already = false
var desired_dialogue_pos: Vector2

var player_node: CharacterBody2D = null

func _ready():
	for i in get_tree().get_nodes_in_group("player"):
		player_node = i

func _process(delta):
	if !player_node:
		for i in get_tree().get_first_node_in_group("player"):
			player_node = i
		return
	
	if !activate_instant and player_body_in:
		if only_activate_once and has_activated_already:
			set_process(false)
			return
	
	if Input.is_action_just_pressed("ui_accept"):
		_activate_dialogue()
		player_body_in = false

func _activate_dialogue():
	player_node.can_move = false
	var camera = get_viewport().get_camera_2d()
	
	var new_dialogue = DialogueSystemPreload.instantiate()
	if override_dialogue_position:
		desired_dialogue_pos = override_position
	else:
		if player_node.global_position.y > camera:
			desired_dialogue_pos = dialogue_top_pos
		else:
			desired_dialogue_pos = dialogue_bottom_pos
	new_dialogue.global_position = desired_dialogue_pos
	new_dialogue.dialogue = dialogue
	get_parent().add_child(new_dialogue)

func _on_body_entered(body: Node2D) -> void:
	if only_activate_once and has_activated_already:
		return
	if body.is_in_group("player"):
		player_body_in = true
		if activate_instant:
			_activate_dialogue()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_body_in = false
