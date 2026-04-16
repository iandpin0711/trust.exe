extends Node2D

@onready var search_bar = $ColorRect/LineEdit 
@onready var error_label = $ColorRect/ErrorMessage 
@onready var error_sound_player = $ErrorSoundPlayer # El nodo que reproduce el audio

@export var error_sound: AudioStream 

const DIARY_1 = "res://scenes/Computer/Programs & Icons/Browser Files/SecretScene1.tscn"
const DIARY_2 = "res://scenes/Computer/Programs & Icons/Browser Files/SecretScene2.tscn"
const DIARY_3 = "res://scenes/Computer/Programs & Icons/Browser Files/SecretScene3.tscn"

func _ready():
	if error_label:
		error_label.visible = false
	
	# Asignamos el sonido del inspector al reproductor
	if error_sound:
		error_sound_player.stream = error_sound

func _on_search_button_pressed():
	_process_search(search_bar.text)

func _on_line_edit_text_submitted(new_text):
	_process_search(new_text)

func _process_search(query: String):
	var clean_query = query.strip_edges().to_lower()
	
	if error_label:
		error_label.visible = false
	
	match clean_query:
		"diary1":
			get_tree().change_scene_to_file(DIARY_1)
		"diary2":
			get_tree().change_scene_to_file(DIARY_2)
		"diary3":
			get_tree().change_scene_to_file(DIARY_3)
		"google":
			print("Searching for normal stuff...")
		_:
			show_error_feedback()

func show_error_feedback():
	if error_label:
		error_label.text = "There are no results for this request..."
		error_label.visible = true
		
		if error_sound_player.stream:
			error_sound_player.play()
		
		await get_tree().create_timer(3.0).timeout
		error_label.visible = false
