extends Control

@onready var count: Label = $count


func _ready() -> void:
	count.text = "You caught " + str(Global.butterflies_caught) + " butterflies!"
