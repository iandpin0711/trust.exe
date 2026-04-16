extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	animated_sprite.play("idle")
	# Sin _physics_process, no hay gravedad aplicada
