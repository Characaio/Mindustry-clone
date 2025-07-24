extends Node

@onready var editor_ogg: AudioStreamPlayer2D = $Editor_ogg
@onready var launch_ogg: AudioStreamPlayer2D = $Launch_ogg
@onready var menu_ogg: AudioStreamPlayer2D = $Menu_ogg
@onready var animation_player: AnimationPlayer = $AnimationPlayer


var musicas:Array[AudioStreamPlayer2D]
var musica:AudioStreamPlayer2D
var escolha:int
signal acabo

func iniciar_musica() -> void:
	
	musica = musicas.pick_random()
	print('eita iniciei o (',musica.get_name(),')')
	musica.playing = true
	
func _ready() -> void:
	musicas = [editor_ogg,launch_ogg,menu_ogg]
	iniciar_musica()
func _process(delta: float) -> void:
	if musica.playing == false:
		iniciar_musica()
		
	
