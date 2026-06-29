extends Control

@onready var button_audio: AudioStreamPlayer = $buttonAudio


func _on_back_pressed() -> void:
	button_audio.play()
	await button_audio.finished
	get_tree().change_scene_to_file("res://guide3.tscn")


func _on_home_pressed() -> void:
	button_audio.play()
	await button_audio.finished
	get_tree().change_scene_to_file("res://menu.tscn")
