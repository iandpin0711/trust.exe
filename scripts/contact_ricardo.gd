extends Node2D

const DialogueSystemP = preload("res://scenes/DialogueSystem.tscn")

@export var dialogue: Array[DE]

@onready var trust_meter = $ProgressBar 

func _ready():
	trust_meter.set_trust_value(25.0)
	
	var new_dialogue = DialogueSystemP.instantiate()
	new_dialogue.dialogue = dialogue
	add_child(new_dialogue)
	
	var screen_size = get_viewport_rect().size
	var x_pos = (screen_size.x / 2) - (new_dialogue.size.x / 2)
	var y_pos = screen_size.y * 0.65
	new_dialogue.position = Vector2(x_pos, y_pos)

func _on_regalo_aceptado():
	var nuevo_valor = trust_meter.progress_bar.value + 10
	trust_meter.set_trust_value(nuevo_valor)


func _on_texture_button_pressed():
	get_tree().change_scene_to_file("res://scenes/Computer/Contact.tscn")
