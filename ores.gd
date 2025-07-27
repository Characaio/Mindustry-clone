extends Node2D


@onready var carvão: AnimatedSprite2D = $Carvão
@onready var cobre: AnimatedSprite2D = $Cobre
@onready var chumbo: AnimatedSprite2D = $Chumbo
@onready var sucata: AnimatedSprite2D = $Sucata
@onready var thorium: AnimatedSprite2D = $Thorium
@onready var titanio: AnimatedSprite2D = $Titanio


var original:Vector2
var posição:Vector2
var MinerioEscolhido:Dictionary
var Minerios:Array[Dictionary]
var sprite:AnimatedSprite2D

@onready var tile_exemplo: TileMapLayer = $TileExemplo

var Carvão:Dictionary
var Chumbo:Dictionary 
var Sucata:Dictionary
var Thorium:Dictionary 
var Titanio:Dictionary
var Cobre:Dictionary

var CopperPocket:Array[Vector2] = [
	Vector2(0,0),Vector2(0,1),Vector2(0,2),Vector2(0,3),
	Vector2(1,0),Vector2(1,1),Vector2(1,2),Vector2(1,3),
	Vector2(2,0),Vector2(2,1),Vector2(2,2),Vector2(2,3),
	Vector2(3,0),Vector2(3,2),Vector2(3,2),Vector2(3,3)
]

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
	Cobre = {
	'Nome': 'Cobre',
	'Prioridade': 1,
	'Sprites': cobre.duplicate()
	}
	Carvão = {
	'Nome': 'Carvão',
	'Prioridade': 2,
	'Sprites': carvão.duplicate()
	}
	Chumbo = {
	'Nome': 'Chumbo',
	'Prioridade': 1,
	'Sprites': chumbo.duplicate()
 	}
	Sucata = {
	'Nome': 'Sucata',
	'Prioridade': 0,
	'Sprites': sucata.duplicate()
	}
	Thorium = {
	'Nome': 'Thorium',
	'Prioridade': 4,
	'Sprites': thorium.duplicate()
	}
	Titanio  = {
	'Nome': 'Titanio',
	'Prioridade': 3,
	'Sprites': titanio.duplicate()
	}
	Minerios = [Cobre,Carvão,Chumbo,Sucata,Titanio,Thorium]
	for i in range(20):
		colocar_minerios()
