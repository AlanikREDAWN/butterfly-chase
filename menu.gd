extends Control


func _on_start_pressed() -> void:
	#Global.game_start.emit()
	get_tree().change_scene_to_file("res://main.tscn")

	


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://settings.tscn")
