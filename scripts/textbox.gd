extends CanvasLayer

func _ready():
	visible = false

func show_text (txt: String):
	visible = true
	$Panel/Label.text = txt

func hide_textbox():
	visible = false
