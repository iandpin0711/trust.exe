extends Node2D

@onready var trust_meter = $ProgressBar 
@onready var timer_label = $TimerLabel 

func _ready():
	trust_meter.set_trust_value(25.0)
	DialogueManager.show_example_dialogue_balloon(load("res://dialogues/ricardo_dialogue.dialogue"), "start")
	

func _on_regalo_aceptado():
	var new_value = trust_meter.progress_bar.value + 10
	trust_meter.set_trust_value(new_value)

func _on_texture_button_pressed():
	var time_text = timer_label.text 
	var final_trust = trust_meter.progress_bar.value
	var is_victory = final_trust >= 80.0
	GlobalData.registrar_llamada("Ricardo", time_text, is_victory, final_trust)
	get_tree().change_scene_to_file("res://scenes/Computer/Contact.tscn")
