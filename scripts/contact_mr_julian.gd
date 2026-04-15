extends Node2D

@onready var trust_meter = $ProgressBar 
@onready var timer_label = $TimerLabel 

# Añadimos los exports de Matilde para poder configurar la escena desde el Inspector
@export var my_dialogue_resource: DialogueResource 
@export var dialogue_start_point: String = "start"
@export var custom_balloon_scene: PackedScene

var trust: float = 15.0
var dice_roll: int = 0 

func _ready():
	trust_meter.set_trust_value(trust)
	
	# Usamos el sistema de Matilde para instanciar el globo personalizado
	if custom_balloon_scene:
		var balloon = custom_balloon_scene.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(my_dialogue_resource, dialogue_start_point)
	else:
		# Por si se te olvida asignar la escena en el Inspector, que no rompa el juego
		DialogueManager.show_example_dialogue_balloon(my_dialogue_resource, dialogue_start_point)

func update_trust(amount: float):
	trust += amount
	trust = clamp(trust, 0, 100)
	trust_meter.set_trust_value(trust)

func get_neutral_result() -> int:
	return randi_range(1, 2)

func _end_scene():
	var time_text = timer_label.text 
	var is_victory = trust >= 80.0 
	GlobalData.registrar_llamada("Mr. Julian", time_text, is_victory, trust)
	get_tree().change_scene_to_file("res://scenes/Computer/Contact.tscn")

func _on_texture_button_pressed():
	_end_scene()
