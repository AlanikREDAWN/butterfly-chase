extends CharacterBody2D

@export var speed: float = 500
var screen_size
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	screen_size = get_viewport_rect().size
	
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if !Global.cat_sleeping:
		if Input.is_action_pressed("move_right"):
			$AnimatedSprite2D.flip_h = true
			velocity.x += 1
		if Input.is_action_pressed("move_left"):
			velocity.x -= 1
			$AnimatedSprite2D.flip_h = false
		if Input.is_action_pressed("move_down"):
			velocity.y += 1
		if Input.is_action_pressed("move_up"):
			velocity.y -= 1
	

	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		if Global.cat_sleeping:
			animated_sprite_2d.play("sleep")
		else:
			animated_sprite_2d.play("walk")
	else:
		if Global.cat_sleeping:
			animated_sprite_2d.play("sleep")
		else:
			animated_sprite_2d.stop()

		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	#position.x = wrapf(position.x, 0, screen_size.x)
	#position.y = wrapf(position.y, 0, screen_size.y)
