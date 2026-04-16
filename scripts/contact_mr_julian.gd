extends Node2D

@onready var trust_meter = $ProgressBar 
@onready var timer_label = $TimerLabel 
@onready var exit_sound_player = $ExitSoundPlayer

@export var my_dialogue_resource: DialogueResource 
@export var dialogue_start_point: String = "start"
@export var custom_balloon_scene: PackedScene

@export var voice_sound: AudioStream
@export var voice_pitch: float = 1.0
@export var voice_speed: int = 5

var trust: float = 15.0
var dice_roll: int = 0 

func _ready():
	trust_meter.set_trust_value(trust)
	
	if custom_balloon_scene:
		var balloon = custom_balloon_scene.instantiate()
		get_tree().current_scene.add_child(balloon)
		
		if balloon.has_method("setup_voice"):
			balloon.setup_voice(voice_sound, voice_pitch, voice_speed)
			
		balloon.start(my_dialogue_resource, dialogue_start_point)
	else:
		DialogueManager.show_example_dialogue_balloon(my_dialogue_resource, dialogue_start_point)

func update_trust(amount: float):
	trust += amount
	trust = clamp(trust, 0, 100)
	trust_meter.set_trust_value(trust)

func get_neutral_result() -> int:
	return randi_range(1, 2)

func _end_scene():
	if exit_sound_player:
		exit_sound_player.play()
		await exit_sound_player.finished
	
	var time_text = timer_label.text 
	var is_victory = trust >= 80.0 
	GlobalData.registrar_llamada("Mr. Julian", time_text, is_victory, int(trust))
	get_tree().change_scene_to_file("res://scenes/Computer/Contact.tscn")

func _on_texture_button_pressed():
	_end_scene()
