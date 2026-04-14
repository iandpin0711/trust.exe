extends Node2D

@onready var trust_meter = $ProgressBar 
# Referencia al Label del tiempo (ajusta la ruta si es distinta)
@onready var timer_label = $TimerLabel 

var trust: float = 50.0
var dice_roll: int = 0 

func _ready():
	trust_meter.set_trust_value(trust)
	DialogueManager.show_example_dialogue_balloon(load("res://dialogues/matilde_dialogue.dialogue"), "start")
	
func update_trust(amount: float):
	trust += amount
	trust = clamp(trust, 0, 100)
	trust_meter.set_trust_value(trust)
	print("Trust actual: ", trust)

func get_neutral_result() -> int:
	return randi_range(1, 2)

func _on_texture_button_pressed():
	var tiempo_texto = timer_label.text 
	var confianza_final = trust_meter.progress_bar.value
	var es_victoria = confianza_final >= 80.0
	GlobalData.registrar_llamada("Matilde", tiempo_texto, es_victoria, confianza_final)
	get_tree().change_scene_to_file("res://scenes/Computer/Contact.tscn")
