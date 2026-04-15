extends Node

var music : AudioStreamPlayer

func _ready() -> void:
	music = AudioStreamPlayer.new()
	add_child(music)
	music.stream = preload("res://assets/sounds/Menu_Controls.mp3")
	music.play()
