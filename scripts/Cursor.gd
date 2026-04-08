extends CharacterBody2D

@export var lerp: float = 0.4

func _physics_process(_delta):
	var mouse_position = get_global_mouse_position()
	
	global_position = global_position.lerp(mouse_position, lerp)
