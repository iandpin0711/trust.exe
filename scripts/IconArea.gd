extends GeneralCursorArea

static var current_instance = null

func change_to_scene():
	if is_instance_valid(current_instance):
		print("Ya hay una escena abierta, ignorando clic.")
		return

	if target_scene:
		var overlay_instance = target_scene.instantiate()
		
		current_instance = overlay_instance
		
		get_tree().current_scene.add_child(overlay_instance)
	
	is_loading = false
	
	if cursor:
		cursor.change_cursor(idle)
