extends Node2D

@onready var timer_label = $TimerLabel 

@export var my_dialogue_resource: DialogueResource 
@export var dialogue_start_point: String = "start"
@export var custom_balloon_scene: PackedScene

func _ready():
	var balloon = custom_balloon_scene.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(my_dialogue_resource, dialogue_start_point)

func _end_scene():
	get_tree().change_scene_to_file("res://scenes/Computer/Programs & Icons/Browser.tscn")

func _on_texture_button_pressed():
	_end_scene()
