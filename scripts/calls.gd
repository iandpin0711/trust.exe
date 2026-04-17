extends Node2D

@onready var grid = $ColorRect/ScrollContainer/GridContainer

func _ready():
	update_interface()

func update_interface():
	while grid.get_child_count() > 4:
		grid.get_child(4).queue_free()
	
	for data in GlobalData.historial_llamadas:
		var name_l = Label.new()
		var time_l = Label.new()
		var status_l = Label.new()
		var trust_l = Label.new()
		
		name_l.text = data.nombre
		time_l.text = data.duracion
		trust_l.text = str(data.confianza) + "%"
		
		# Set status text and color directly
		status_l.text = "SUCCESS" if data.victoria else "FAILED"
		var status_color = Color.GREEN if data.victoria else Color.RED
		status_l.add_theme_color_override("font_color", status_color)
		
		# Apply common settings to all 4 labels
		for label in [name_l, time_l, status_l, trust_l]:
			# Only apply black to non-status labels
			if label != status_l:
				label.add_theme_color_override("font_color", Color.BLACK)
			
			label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			grid.add_child(label)
