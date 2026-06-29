extends Node

signal butterfly_caught
signal spawn_butterfly
#signal game_start

@onready var butterflies_caught = 0
#@onready var game_timer: Timer
@onready var game_length
@onready var game_active = false
@onready var cat_sleeping = false
@onready var evil_chase = true
