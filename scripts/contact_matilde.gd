extends Node2D

@onready var trust_meter = $ProgressBar 

func _ready():
	trust_meter.set_trust_value(50.0)

func _on_regalo_aceptado():
	var nuevo_valor = trust_meter.progress_bar.value + 10
	trust_meter.set_trust_value(nuevo_valor)
