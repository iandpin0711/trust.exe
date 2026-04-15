extends Node2D

@onready var startup_sound = $WindowsXpStartup

func _ready():
	if not GlobalData.windows_started:
		startup_sound.play()
		GlobalData.windows_started = true 
