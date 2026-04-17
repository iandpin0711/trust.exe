extends Control

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_play_again_pressed() -> void:
	$Click.play()
	await $Click.finished
	get_tree().change_scene_to_file("res://scenes/Office.tscn")

func _on_main_menu_pressed() -> void:
	$Click.play()
	await $Click.finished
	get_tree().change_scene_to_file("res://scenes/Ui/MainMenu.tscn")
