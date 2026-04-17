extends TextureRect

@onready var bus_index = AudioServer.get_bus_index("Master")

func _on_h_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		var nuevo_volumen = $HSlider.value
		AudioServer.set_bus_volume_db(bus_index, nuevo_volumen)
		AudioServer.set_bus_mute(bus_index, nuevo_volumen <= 0)
		$SoundEffect.play()

func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, value)
	AudioServer.set_bus_mute(bus_index, value <= -29)
