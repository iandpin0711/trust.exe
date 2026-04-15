extends Node2D

@onready var trust_meter = $ProgressBar 
@onready var timer_label = $TimerLabel 

# Export variables to configure the scene from the Inspector
@export var my_dialogue_resource: DialogueResource 
@export var dialogue_start_point: String = "start"
@export var custom_balloon_scene: PackedScene

var trust: float = 15.0
var dice_roll: int = 0 

func _ready():
	trust_meter.set_trust_value(trust)
	
	# Instantiate the custom balloon if it exists
	if custom_balloon_scene:
		var balloon = custom_balloon_scene.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(my_dialogue_resource, dialogue_start_point)
	else:
		# Fallback to the default balloon if no custom scene is assigned
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
	GlobalData.registrar_llamada("Mr. Julian", time_text, is_victory, int(trust))
	get_tree().change_scene_to_file("res://scenes/Computer/Contact.tscn")

func _on_texture_button_pressed():
	_end_scene()
