extends CharacterBody2D

@export var speed = 300
@export var max_force = 400
@export var max_speed = 300
@export var mass = 1.0
@export var prediction_factor: float = 0.1
@export var wander_range = 1000
@export var acceleration = 300
@onready var start_position = global_position
@onready var target_position = global_position
@onready var evil_timer: Timer
@onready var sleep_timer: Timer

var wanderAngle: float = 0.0
var screen_size
var target = null
var is_chasing = false

func _ready() -> void:
	evil_timer = Timer.new()
	#evil_timer.name = "EvilTimer"
	add_child(evil_timer)
	
	evil_timer.wait_time = 10
	evil_timer.one_shot = true

	
	evil_timer.timeout.connect(_on_evil_timer_timeout)
	
	evil_timer.start()
	
	screen_size = get_viewport_rect().size

func _on_evil_timer_timeout():
	if Global.cat_sleeping == false:
		Global.spawn_butterfly.emit()
		queue_free()

func _physics_process(delta: float) -> void:
	if is_chasing and Global.evil_chase == true:
		pursue()
	else: 
		wander(delta)
	position = position.clamp(Vector2.ZERO, screen_size)
	move_and_slide()

func pursue() -> void:
	var future_pos = target.position + target.velocity * prediction_factor
	velocity = -((position - future_pos).normalized() * speed)
	return

func wander(delta):
	var target_vector = Vector2(randi_range(-wander_range, wander_range), randi_range(-wander_range, wander_range))
	target_position = start_position + target_vector
	
	var direction = global_position.direction_to(target_position)
	velocity = velocity.move_toward(direction * speed, acceleration * delta)

func _on_collision_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		hide()
		is_chasing = false
		Global.evil_chase = false
		Global.cat_sleeping = true
		sleep_timer = Timer.new()

		add_child(sleep_timer)
	
		sleep_timer.wait_time = 5
		sleep_timer.one_shot = true

	
		sleep_timer.timeout.connect(_on_sleep_timer_timeout)
	
		sleep_timer.start()

func _on_sleep_timer_timeout():
	Global.spawn_butterfly.emit()
	Global.cat_sleeping = false
	Global.evil_chase = true
	queue_free()

func _on_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		target = body
		is_chasing = true


func _on_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		target = null
		is_chasing = false
