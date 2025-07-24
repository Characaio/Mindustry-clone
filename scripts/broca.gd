extends Node2D
class_name broca

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func começar_animação() -> void:
	animation_player.play("rotação")
