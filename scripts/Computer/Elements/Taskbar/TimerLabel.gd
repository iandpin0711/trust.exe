extends Label

var elapsed_time: float = 0.0

func _process(delta):
	elapsed_time += delta
	var mins = int(elapsed_time) / 60
	var secs = int(elapsed_time) % 60
	text = "%02d:%02d" % [mins, secs]
