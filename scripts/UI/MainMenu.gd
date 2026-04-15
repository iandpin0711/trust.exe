extends Control

@onready var music: AudioStreamPlayer = $AudioStreamPlayer

var MenuMusic = preload("res://assets/sounds/Menu_Controls.mp3")

func _ready() -> void:
	music.stream = MenuMusic
	music.play()
	
func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Office.tscn")

func _on_controls_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Ui/Controls.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
