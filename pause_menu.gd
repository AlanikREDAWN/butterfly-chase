extends CanvasLayer

@onready var unpause_audio: AudioStreamPlayer = $unpauseAudio
@onready var pause_audio: AudioStreamPlayer = $pauseAudio


func _ready() -> void:
	visible = false
	get_tree().paused = false

func _on_resume_pressed() -> void:
	unpause_audio.play()
	visible = false
	get_tree().paused = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused:
			unpause_audio.play()
			visible = false
			get_tree().paused = false
		else:
			pause_audio.play()
			visible = true
			get_tree().paused = true
