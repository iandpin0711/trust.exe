extends CharacterBody2D

@export var lerp: float = 1
@onready var sprite = $AnimatedSprite2D

func _ready():
	add_to_group("Cursor")
	sprite.play("idle")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _physics_process(_delta):
	var mouse_position = get_global_mouse_position()
	
	global_position = global_position.lerp(mouse_position, lerp)

func change_cursor_appearance(animation_name: String):
	if sprite.animation != animation_name:
		sprite.play(animation_name)
