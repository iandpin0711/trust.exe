extends TextureButton

const OFFICE_SCENE_PATH = "res://scenes/Office.tscn"

func _ready():
	self.pressed.connect(_on_pressed)

func _on_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	var error = get_tree().change_scene_to_file(OFFICE_SCENE_PATH)
	
	if error != OK:
		print("Error al volver a la oficina: ", error)
