extends Node2D


@onready var carvão: AnimatedSprite2D = $Carvão
@onready var cobre: AnimatedSprite2D = $Cobre
@onready var chumbo: AnimatedSprite2D = $Chumbo
@onready var sucata: AnimatedSprite2D = $Sucata
@onready var thorium: AnimatedSprite2D = $Thorium
@onready var titanio: AnimatedSprite2D = $Titanio

var Sprites: Dictionary
var original:Vector2
var posição:Vector2
var MinerioEscolhido:Dictionary
var Minerios:Array[Dictionary]
var sprite:AnimatedSprite2D

@onready var tile_exemplo: TileMapLayer = $TileExemplo

func colocar_minerios() -> void:
	
	posição = Vector2(randi_range(0,10),randi_range(0,10))
	MinerioEscolhido = Minerios.duplicate(true).pick_random()
	sprite = MinerioEscolhido['Sprites'].duplicate()
	sprite.position = tile_exemplo.map_to_local(posição)
	sprite.frame = randi_range(0,2)
	sprite.visible = true
	print(posição)
	get_node("SLAKARAI").add_child(sprite)
	GeneralInformation.colocar_minerios(posição,MinerioEscolhido)
	


func _ready() -> void:
	Sprites = {
		'Carvão': carvão,
		'Cobre':cobre,
		'Chumbo':chumbo,
		'Sucata':sucata,
		'Thorium':thorium,
		'Titanio':titanio
	}
	Ore.colocar_sprites(Sprites)
	Ore.criar_minerios()
	
	Minerios = Ore.pegar_minerios()
	for i in range(20):
		colocar_minerios()
