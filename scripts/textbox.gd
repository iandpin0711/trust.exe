extends CanvasLayer
@export var text_speed : float = 0.05

var complete_text : String = ""
var visible_text : String = ""
var index : int = 0
var writing : bool = false

@onready var label = $NinePatchRect/Label

func _ready():
	visible = false

func show_text (txt: String):
	complete_text = txt
	index = 0
	visible = true
	writing = true
	_write()

func _write():
	while index < complete_text.length():
		visible_text += complete_text[index]
		label.text = visible_text
		index += 1
		await get_tree().create_timer(text_speed).timeout
		writing = false

func hide_textbox():
	visible = false
	writing = false
