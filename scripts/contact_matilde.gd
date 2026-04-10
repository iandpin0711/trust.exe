extends Node2D

const DialogueSystemP = preload("res://scenes/DialogueSystem.tscn")

@export var dialogue: Array[DE]

@onready var trust_meter = $ProgressBar 

func _ready():
	trust_meter.set_trust_value(50.0)
	
	var new_dialogue = DialogueSystemP.instantiate()
	new_dialogue.dialogue = dialogue
	add_child(new_dialogue)

func _on_correct_option():
	var new_value = trust_meter.progress_bar.value + 10
	trust_meter.set_trust_value(new_value)
