extends Node2D

@onready var trust_meter = $ProgressBar 
# Referencia al Label del tiempo (ajusta la ruta si es distinta)
@onready var timer_label = $TimerLabel 

func _ready():
	trust_meter.set_trust_value(50.0)
	DialogueManager.show_example_dialogue_balloon(load("res://dialogues/game_dialogues.dialogue"),"nivel_1")
	

func _on_correct_option():
	var new_value = trust_meter.progress_bar.value + 10
	trust_meter.set_trust_value(new_value)

func _on_texture_button_pressed():
	var tiempo_texto = timer_label.text 
	var confianza_final = trust_meter.progress_bar.value
	var es_victoria = confianza_final >= 80.0
	GlobalData.registrar_llamada("Matilde", tiempo_texto, es_victoria, confianza_final)
	get_tree().change_scene_to_file("res://scenes/Computer/Contact.tscn")
