extends CharacterBody2D

@export var speed = 300
var screen_size
var target = null

func _ready() -> void:
	screen_size = get_viewport_rect().size
	

#func _physics_process(delta: float) -> void:
	#if player:
		#_flee(delta)

	#move_and_slide()
	#if player:
		#velocity = -position.direction_to(player.position)
		#velocity = velocity.normalized() * speed
		#position += velocity * delta
		#move_and_slide()
	#else:
		#velocity = Vector2.ZERO
		#
	#position = position.clamp(Vector2.ZERO, screen_size)
	
#func _flee(delta: float) -> void:
	#var direction = -(player.position - position).normalized()
	#position += direction * speed * delta

func _on_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		target = body
		#print("body entered")


func _on_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		target = null
