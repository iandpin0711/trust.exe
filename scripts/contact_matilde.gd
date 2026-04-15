extends Node2D

@onready var trust_meter = $ProgressBar 
@onready var timer_label = $TimerLabel 

@export var my_dialogue_resource: DialogueResource 
@export var dialogue_start_point: String = "start"
@export var custom_balloon_scene: PackedScene

var trust: float = 50.0
var dice_roll: int = 0 

func _ready():
	trust_meter.set_trust_value(trust)
	var balloon = custom_balloon_scene.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(my_dialogue_resource, dialogue_start_point)

#	DialogueManager.show_example_dialogue_balloon(my_dialogue_resource, dialogue_start_point)
	
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
