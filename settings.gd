extends Control


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")


func _on_time_text_submitted(new_text: String) -> void:
	var input_number = new_text.to_float()
	
	if input_number > 0:
		Global.game_length = input_number
	else:
		print("number must be greater than 0") 
		# TODO: show on screen
