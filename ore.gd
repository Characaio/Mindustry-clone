extends Node2D

var Carvão:Dictionary
var Chumbo:Dictionary 
var Sucata:Dictionary
var Thorium:Dictionary 
var Titanio:Dictionary
var Cobre:Dictionary

var CarvãoSprite: AnimatedSprite2D
var CobreSprite: AnimatedSprite2D
var ChumboSprite: AnimatedSprite2D
var SucataSprite: AnimatedSprite2D
var ThoriumSprite: AnimatedSprite2D
var TitanioSprite: AnimatedSprite2D

var Minerios: Array[Dictionary]

func colocar_sprites(Sprites) -> void:
	CarvãoSprite = Sprites['Carvão']
	CobreSprite = Sprites['Cobre']
	ChumboSprite = Sprites['Chumbo']
	SucataSprite = Sprites['Sucata']
	ThoriumSprite = Sprites['Thorium']
	TitanioSprite = Sprites['Titanio']
	
func pegar_minerios() -> Array[Dictionary]:
	return Minerios
	
func criar_minerios() -> void:
	Cobre = {
	'Nome': 'Cobre',
	'Cor': Color.from_rgba8(200,164,117),
	'Prioridade': 1,
	'Quantidade': 0,
	'Sprites': CobreSprite
	}
	Carvão = {
	'Nome': 'Carvão',
	'Cor': Color.from_rgba8(39,39,39),
	'Prioridade': 2,
	'Quantidade': 0,
	'Sprites': CarvãoSprite
	}
	Chumbo = {
	'Nome': 'Chumbo',
	'Cor': Color.from_rgba8(142,133,162),
	'Prioridade': 1,
	'Quantidade': 0,
	'Sprites': ChumboSprite
 	}
	Sucata = {
	'Nome': 'Sucata',
	'Cor': Color.from_rgba8(155,146,139),
	'Prioridade': 0,
	'Quantidade': 0,
	'Sprites': SucataSprite
	}
	Thorium = {
	'Nome': 'Thorium',
	'Cor': Color.from_rgba8(205,159,207),
	'Prioridade': 4,
	'Quantidade': 0,
	'Sprites': ThoriumSprite
	}
	Titanio  = {
	'Nome': 'Titanio',
	'Cor': Color.from_rgba8(120,141,207),
	'Prioridade': 3,
	'Quantidade': 0,
	'Sprites': TitanioSprite
	}
	Minerios = [Cobre,Carvão,Chumbo,Sucata,Titanio,Thorium]
