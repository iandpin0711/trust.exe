extends Node2D

@onready var trust_meter = $ProgressBar 

func _ready():
	trust_meter.set_trust_value(15.0)

func _on_correct_option():
	var new_value = trust_meter.progress_bar.value + 10
	trust_meter.set_trust_value(new_value)
