extends Node

const BROCA = preload("res://cenas/broca.tscn")
const ESTEIRA = preload("res://cenas/esteira.tscn")
const NUCLEO = preload("res://cenas/nucleo.tscn")
const PRENSA_DE_GRAFITE = preload("res://cenas/prensa-de-grafite.tscn")

const Inspecionar:Dictionary = {
	'id': -1
}

const PrensaDeGrafite:Dictionary = {
	'id': 0,
	'cena': PRENSA_DE_GRAFITE,
	'tipo_de_bloco': 'Fabrica',
	'tamanhox': 2,
	'tamanhoy': 2,
	'Rotacional': false,
	'direção': 0,
	'nome': 'PrensaDeGrafite'
}

const Esteira:Dictionary = {
	'id': 1,
	'cena': ESTEIRA,
	'tipo_de_bloco': 'Esteira',
	'tamanhox': 1,
	'tamanhoy': 1,
	'Rotacional': true,
	'direção': 0,
	'nome': 'Esteira',
	'limite_da_esteira': 5,
	'estoque_da_esteira': 0,
	'velocidade_da_esteira': 2 #passsa 2 minerios por segundo
}

const Nucleo:Dictionary =  {
	'id': 2,
	'cena': NUCLEO,
	'tipo_de_bloco': 'Nucleo',
	'tamanhox': 3,
	'tamanhoy': 3,
	'Rotacional': false,
	'direção': 0,
	'nome': 'Nucleo'
}

const Broca:Dictionary = {
	'id':3,
	'cena': BROCA,
	'tipo_de_bloco': 'Broca',
	'tamanhox': 2,
	'tamanhoy': 2,
	'Rotacional': false,
	'direção': 0,
	'nome': 'Broca'
}

var DataBase:Dictionary

func _ready() -> void:
	DataBase = {
		'Inspecionar': Inspecionar,
		'Prensa_De_Grafite' : PrensaDeGrafite,
		'Esteira':Esteira,
		'Nucleo':Nucleo,
		'Broca':Broca
	}
	
func get_tile(Escolha_Primeira:String) -> Dictionary:
	#print(DataBase)
	if DataBase.has(Escolha_Primeira):
		#print(DataBase[Escolha_Primeira])
		return DataBase[Escolha_Primeira].duplicate(true)
	return Inspecionar
