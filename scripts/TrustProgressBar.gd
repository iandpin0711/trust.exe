extends Control

@onready var progress_bar = $TextureProgressBar
@onready var percent_label = $TrustPercent
@export var color_gradient: Gradient

func _ready():
	GlobalData.trust_bar_node = self
	update_ui()

func set_trust_value(value: float):
	if progress_bar:
		progress_bar.value = clamp(value, 0, 100)
		update_ui()

func update_ui():
	if not progress_bar or not percent_label: return
	
	var current_val = progress_bar.value
	percent_label.text = str(int(current_val)) + "%"
	
	if color_gradient:
		var ratio = current_val / progress_bar.max_value
		percent_label.modulate = color_gradient.sample(ratio)
