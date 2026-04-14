extends Node2D

@onready var trust_meter = $ProgressBar 
@onready var timer_label = $TimerLabel 

func _ready():
	trust_meter.set_trust_value(15.0)
	
	

func _on_correct_option():
	var new_value = trust_meter.progress_bar.value + 10
	trust_meter.set_trust_value(new_value)

func _on_texture_button_pressed():
	var time_text = timer_label.text 
	var final_trust = trust_meter.progress_bar.value
	var is_victory = final_trust >= 80.0
	GlobalData.registrar_llamada("Mr. Julian", time_text, is_victory, final_trust)
	get_tree().change_scene_to_file("res://scenes/Computer/Contact.tscn")
