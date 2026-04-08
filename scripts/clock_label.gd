extends Label

func _process(_delta):
	var time = Time.get_time_dict_from_system()
	var format_string = "%02d:%02d"
	var actual_time = format_string % [time.hour, time.minute]

	text = actual_time
