extends Node2D

const DialogueSystemP = preload("res://scenes/DialogueSystem.tscn")

@export var dialogue: Array[DE]

@onready var trust_meter = $ProgressBar 
# Referencia al Label del tiempo (ajusta la ruta si es distinta)
@onready var timer_label = $TimerLabel 

func _ready():
	trust_meter.set_trust_value(50.0)
	
	var new_dialogue = DialogueSystemP.instantiate()
	new_dialogue.dialogue = dialogue
	add_child(new_dialogue)
	
	var screen_size = get_viewport_rect().size
	var x_pos = (screen_size.x / 2) - (new_dialogue.size.x / 2)
	var y_pos = screen_size.y * 0.65
	new_dialogue.position = Vector2(x_pos, y_pos)

func _on_correct_option():
	var new_value = trust_meter.progress_bar.value + 10
	trust_meter.set_trust_value(new_value)

func _on_texture_button_pressed():
	var tiempo_texto = timer_label.text 
	var confianza_final = trust_meter.progress_bar.value
	var es_victoria = confianza_final >= 80.0
	GlobalData.registrar_llamada("Matilde", tiempo_texto, es_victoria, confianza_final)
	get_tree().change_scene_to_file("res://scenes/Computer/Contact.tscn")
