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
