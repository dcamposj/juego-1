extends Control

# Asegúrate de que esta ruta sea EXACTA a la de tu archivo
@export_file("*.tscn") var game_scene_path: String = "res://scenes/game.tscn"

func _on_start_pressed() -> void:
	# Verificamos que la ruta no esté vacía
	if game_scene_path == "":
		print("Error: No has configurado la ruta de la escena en el inspector.")
		return
		
	get_tree().change_scene_to_file(game_scene_path)

func _on_exit_pressed() -> void:
	get_tree().quit()
