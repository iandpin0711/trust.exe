extends Node

var music : AudioStreamPlayer

func _ready() -> void:
	music = AudioStreamPlayer.new()
	add_child(music)
	music.stream = preload("res://assets/sounds/Menu_Controls.mp3")
	music.play()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("stop_music"):
		if music.playing:
			music.stop()
		else:
			music.play()
