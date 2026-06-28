extends Control

@onready var button_audio: AudioStreamPlayer = $buttonAudio


func _on_start_pressed() -> void:
	button_audio.play()
	await button_audio.finished

	#Global.game_start.emit()
	get_tree().change_scene_to_file("res://main.tscn")

	


func _on_settings_pressed() -> void:
	button_audio.play()
	await button_audio.finished
	get_tree().change_scene_to_file("res://settings.tscn")
