extends Node

var historial_llamadas = []
var windows_started: bool = false
var victims_hacked: Array = [] # Nueva lista para rastrear éxitos únicos
var total_needed: int = 3 # Número de víctimas para ganar

func registrar_llamada(nombre: String, tiempo: String, exito: bool, confianza: int):
	var nueva_info = {
		"nombre": nombre,
		"duracion": tiempo,
		"victoria": exito,
		"confianza": confianza
	}
	historial_llamadas.append(nueva_info)
	print("Llamada guardada: ", nueva_info) 

	# Lógica para la victoria global
	if exito and not victims_hacked.has(nombre):
		victims_hacked.append(nombre)
		print("Víctimas hackeadas: ", victims_hacked.size(), "/", total_needed)
		_check_game_over()

func _check_game_over():
	if victims_hacked.size() >= total_needed:
		get_tree().create_timer(1.0).timeout.connect(func():
			get_tree().change_scene_to_file("res://scenes/Ui/Win.tscn")
		)

var trust_bar_node = null

func update_trust(amount: int):
	if trust_bar_node:
		var new_val = trust_bar_node.progress_bar.value + amount
		trust_bar_node.set_trust_value(new_val)
	else:
		print("Error: No hay una barra de confianza registrada.")

func get_trust() -> float:
	if trust_bar_node:
		return trust_bar_node.progress_bar.value
	return 0.0
