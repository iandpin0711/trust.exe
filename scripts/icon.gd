extends Button

@export var program_name: String = "Programa"
@export var icon_image: AtlasTexture 

func _ready():
	$VBoxContainer/Label.text = program_name
	$VBoxContainer/TextureRect.texture = icon_image
