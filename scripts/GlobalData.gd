extends Node

var historial_llamadas = []
var windows_started: bool = false

func registrar_llamada(nombre: String, tiempo: String, exito: bool, confianza: int):
	var nueva_info = {
		"nombre": nombre,
		"duracion": tiempo,
		"victoria": exito,
		"confianza": confianza
	}
	historial_llamadas.append(nueva_info)
	print("Llamada guardada: ", nueva_info) 

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
