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
#@export var CIRCLE_DISTANCE = 3
#@export var CIRCLE_RADIUS = 6
#@export var ANGLE_CHANGE = 5
var wanderAngle: float = 0.0
#var max_velocity: float = 300
var screen_size
var chased_by = null
var is_being_chased = false

func _ready() -> void:
	screen_size = get_viewport_rect().size
	

func _physics_process(delta: float) -> void:
	if is_being_chased:
		#flee()
		evade()
	else: 
		wander(delta)
		#var steering = wander()
		#velocity = steering * delta
		#velocity = velocity.limit_length(speed)
		

	#position.x = wrapf(position.x, 0, screen_size.x)
	#position.y = wrapf(position.y, 0, screen_size.y)

	position = position.clamp(Vector2.ZERO, screen_size)
	move_and_slide()
	#if player:
		#velocity = -position.direction_to(player.position)
		#velocity = velocity.normalized() * speed
		#position += velocity * delta
		#move_and_slide()
	#else:
		#velocity = Vector2.ZERO
		
	

func evade() -> void:
	var future_pos = chased_by.position + chased_by.velocity * prediction_factor
	velocity = (position - future_pos).normalized() * speed
	return
	#var futurePosition = chased_by.position + chased_by.velocity * prediction_factor
	#return flee(futurePosition) 
	

func flee(future_position) -> void:
	var desired_velocity = (future_position - chased_by.velocity).normalized() * speed
	var steering = desired_velocity - velocity
	#if steering.length() > max_force:
	steering = steering.normalized() * max_force
	#steering = steering / mass
	#if (velocity + steering).length() > max_speed:
	velocity = (velocity + steering).normalized() * max_speed
	#position = position + velocity
	#velocity = steering
	#var future_pos = chased_by.position + chased_by.velocity * prediction_factor
	#velocity = (position - future_pos).normalized() * speed

func wander(delta):
	var target_vector = Vector2(randi_range(-wander_range, wander_range), randi_range(-wander_range, wander_range))
	target_position = start_position + target_vector
	
	var direction = global_position.direction_to(target_position)
	velocity = velocity.move_toward(direction * speed, acceleration * delta)
	#var circleCenter: Vector2
	#circleCenter = Vector2(velocity)
	#circleCenter.normalized()
	#circleCenter *= CIRCLE_DISTANCE
	#
	#var displacement: Vector2
	#displacement = Vector2(0, -1)
	#displacement *= CIRCLE_RADIUS
	#
	#setAngle(displacement, wanderAngle)
	#
	#wanderAngle += randf() * ANGLE_CHANGE - ANGLE_CHANGE * .5
	#
	#var wanderForce: Vector2
	#wanderForce = circleCenter + displacement
	#velocity = wanderForce * delta
	##velocity = velocity.limit_length(speed)
	##return wanderForce
	#
	##velocity = Vector2.ZERO

func setAngle(vector: Vector2, value: int) -> void:
	var len: int = vector.length()
	vector.x = cos(deg_to_rad(value)) * len
	vector.y = sin(deg_to_rad(value)) * len

#func _flee(delta: float) -> void:
	#var direction = -(player.position - position).normalized()
	#position += direction * speed * delta

func _on_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		chased_by = body
		is_being_chased = true
		#print("body entered")


func _on_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		chased_by = null
		is_being_chased = false


func _on_collision_body_entered(body: Node2D) -> void:
	Global.butterfly_caught.emit()
	queue_free()
