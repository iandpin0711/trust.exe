extends Control

@onready var progress_bar = $TextureProgressBar
@onready var percent_label = $TrustPercent
@export var color_gradient: Gradient

func _process(_delta):
	var current_val = progress_bar.value
	percent_label.text = str(int(current_val)) + "%"
	
	if color_gradient:
		var ratio = current_val / progress_bar.max_value
		var dynamic_color = color_gradient.sample(ratio)
		percent_label.modulate = dynamic_color

func set_trust_value(value: float):
	progress_bar.value = clamp(value, 0, 100)
