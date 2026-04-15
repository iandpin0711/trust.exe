extends Node

var music: AudioStreamPlayer
var music_scenes = ["MainMenu", "Control"]

func _ready() -> void:
	music = AudioStreamPlayer.new()
	add_child(music)
	music.stream = preload("res://assets/sounds/MainMenu.mp3")
	set_process_unhandled_input(true)
	get_tree().root.connect("child_entered_tree", _on_scene_changed)

func _on_scene_changed(node: Node) -> void:
	await get_tree().process_frame
	var scene_name = get_tree().current_scene.name
	print("Escena actual: ", scene_name)
	if scene_name in music_scenes:
		music.stream_paused = false
		if not music.playing:
			music.play()
	else:
		music.stop()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("stop_music"):
		music.stream_paused = not music.stream_paused
