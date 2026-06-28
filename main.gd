extends Node2D

@onready var screenSize = get_viewport().get_visible_rect().size
@onready var butterflyLabel: Label = $butterflyLabel
@onready var game_timer: Timer
@onready var time_label: Label = $timeLabel



func _ready() -> void:
	game_start()
	Global.butterfly_caught.connect(_on_butterfly_caught)
	#Global.game_start.connect(_on_game_start)

func _on_butterfly_caught():
	print("butterfly caught")
	Global.butterflies_caught += 1
	butterflyLabel.text = "Butterflies Caught: " + str(Global.butterflies_caught)
	var rng = RandomNumberGenerator.new()
	var rndX = rng.randi_range(0, screenSize.x)
	var rndY = rng.randi_range(0, screenSize.y)
	var butterfly_scene = load("res://butterfly.tscn")
	var butterfly = butterfly_scene.instantiate()
	add_child.call_deferred(butterfly)
	butterfly.global_position = Vector2(rndX, rndY)

func game_start():
	Global.game_active = true
	print("GAME STARTED")
	game_timer = Timer.new()
	game_timer.name = "GameTimer"
	add_child(game_timer)
	
	if Global.game_length:
		game_timer.wait_time = Global.game_length * 60
	else:
		game_timer.wait_time = 1 * 60
	game_timer.one_shot = true

	
	game_timer.timeout.connect(_on_game_timer_timeout)
	
	game_timer.start()
	
func _on_game_timer_timeout():
	Global.game_active = false
	get_tree().change_scene_to_file("res://end.tscn")

func _process(delta: float) -> void:
	time_label.set_text(str(int(game_timer.get_time_left())))
