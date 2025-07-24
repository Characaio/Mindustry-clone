extends Node2D
@onready var icon: Sprite2D = $Icon

var pressed:bool = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed('e'):
		pressed = true
	if Input.is_action_just_pressed('r'):
		if not pressed:
			icon.rotation_degrees += 90
