extends Node2D

@onready var player_tile_map: TileMapLayer = $"../../Tiles/Player TileMap"

var PosDoMouseNaGrid:Vector2
var MapaDaGrid:Dictionary
var Escolha:Dictionary
var item
var ghost
var Rotação:int 
var PosDoTemp:Vector2
const BROCA = preload("res://broca.tscn")
const ESTEIRA = preload("res://esteira.tscn")
const NUCLEO = preload("res://nucleo.tscn")
const PRENSA_DE_GRAFITE = preload("res://prensa-de-grafite.tscn")
const CaminhoDosGhost:String = '../../Estruturas/Ghosting'
const CaminhoDasEstruturas:String = '../../Estruturas/'

var Inspecionar:Dictionary = {
	'id': -1
}

var PrensaDeGrafite:Dictionary = {
	'id': 0,
	'cena': PRENSA_DE_GRAFITE,
	'tipo_de_bloco': 'Fabrica',
	'tamanhox': 2,
	'tamanhoy': 2,
	'Rotacional': false,
	'direção': 0,
	'nome': 'PrensaDeGrafite'
}

var Esteira:Dictionary =  {
	'id': 1,
	'cena': ESTEIRA,
	'tipo_de_bloco': 'Esteira',
	'tamanhox': 1,
	'tamanhoy': 1,
	'Rotacional': true,
	'direção': 0,
	'nome': 'Esteira'
}

var Nucleo:Dictionary =  {
	'id': 2,
	'cena': NUCLEO,
	'tipo_de_bloco': 'Nucleo',
	'tamanhox': 3,
	'tamanhoy': 3,
	'Rotacional': false,
	'direção': 0,
	'nome': 'Nucleo'
}

var Broca:Dictionary =  {
	'id':3,
	'cena': BROCA,
	'tipo_de_bloco': 'Broca',
	'tamanhox': 2,
	'tamanhoy': 2,
	'Rotacional': false,
	'direção': 0,
	'nome': 'Broca'
}

var MouseAntigo
var MouseNovo
func _ready() -> void:
	
	Escolha = PrensaDeGrafite
	item = Escolha['cena'].instantiate()
	

func teste() -> void:
	print('teste')
	
func handle_click() -> void:
	
	var temp:Array
	var chilling:bool = true
	var PosDaCelulaGlobal:Vector2
	for x in range(Escolha['tamanhox']):
		for y in range(Escolha['tamanhoy']):
			print('sla karaiiiii')
			var PosDaCelulaLocal:Vector2 = Vector2(x,y)
			if Escolha['tamanhox'] == 3:
				PosDaCelulaGlobal= PosDoMouseNaGrid + PosDaCelulaLocal + Vector2(-1,-1)
			else:
				PosDaCelulaGlobal = PosDoMouseNaGrid + PosDaCelulaLocal
			temp.append(PosDaCelulaGlobal)
			if MapaDaGrid.has(PosDaCelulaGlobal):
				
				print('fudeu1')
				if MapaDaGrid[PosDaCelulaGlobal]['tipo_de_bloco'] != 'Esteira':
					chilling = false
	if chilling:
		for chave in temp:
			#print('chave BRABA:', chave)
			
			GeneralInformation.mudar_grid(PosDoMouseNaGrid,chave,Escolha)
		print('to zen')
		spawnar_bloco()
		
	else:
		print('fudeu2')


func spawnar_bloco() -> void:
	item = Escolha['cena'].instantiate()
	item.position = player_tile_map.map_to_local(PosDoMouseNaGrid)

	get_node(CaminhoDasEstruturas).add_child(item)
	
	if item.has_method('identificar_lados'):
		MapaDaGrid[PosDoMouseNaGrid]['direção'] = Rotação
		item.rotação = Rotação
		GeneralInformation.reescrever(MapaDaGrid)
		item.identificar_lados()
		item.arrow.visible = false
		
	if item.has_method('começar_animação'):
		item.começar_animação()
	
func Atualizar_Ghost() -> void:
	for node:Node2D in get_node(CaminhoDosGhost).get_children():
		if node.has_method('rotacionar_ghost'):
			node.rotacionar_ghost(Rotação)
		#print('direçãozinha: ', node.rotation_degrees, '\nRotação: ', Rotação)
		node.position = player_tile_map.map_to_local(PosDoMouseNaGrid)
		
		
func limpar_baguios() -> void:
	print('limpandp')
	Rotação = 0
	for node:Node2D in get_node(CaminhoDosGhost).get_children():
		node.queue_free()
		
func spawnar_ghost() -> void:
	if Escolha == Inspecionar:
		return
	print('teste1')
	ghost = Escolha['cena'].instantiate()
	if not get_node(CaminhoDosGhost).get_children():
		ghost.modulate.a = 0.5
		ghost.rotation_degrees = Rotação
		print('rotação do ghost: ', ghost.rotation_degrees)
		get_node(CaminhoDosGhost).add_child(ghost)
		if Escolha['tipo_de_bloco']  == 'Esteira':
			ghost.arrow.visible = true

func _process(delta: float) -> void:
	MapaDaGrid = GeneralInformation.pegar_grid()
	PosDoMouseNaGrid = player_tile_map.local_to_map(get_global_mouse_position())
	GeneralInformation.atualizar_mouse(PosDoMouseNaGrid)
	
func _physics_process(delta: float) -> void:
	#print('PosDoMouseNaGrid',PosDoMouseNaGrid,'PosDoTemp', PosDoTemp)
	if Input.is_action_pressed('m1'):
		if Escolha != Inspecionar:
			handle_click()
		else:
			print('posição do mouse: ', PosDoMouseNaGrid)
			if MapaDaGrid.has(PosDoMouseNaGrid):
				print('dados da celula: ', MapaDaGrid[PosDoMouseNaGrid])
	
	if Input.is_action_just_pressed("0"):
		limpar_baguios()
		Escolha = Inspecionar
		
	if Input.is_action_just_pressed('1'):
		limpar_baguios()
		Escolha = PrensaDeGrafite
		
	if Input.is_action_just_pressed('2'):
		limpar_baguios()
		Escolha = Esteira
		
	if Input.is_action_just_pressed('3'):
		limpar_baguios()
		Escolha = Nucleo
		
	if Input.is_action_just_pressed('4'):
		limpar_baguios()
		Escolha = Broca
		
	if Input.is_action_just_pressed('r'):
		if Escolha['Rotacional']:
			print('ain, rotacioneiii')
			Rotação += 90
			if Rotação == 360:
				Rotação = 0
			print(Rotação)
			
	
		
	if not get_node(CaminhoDosGhost).get_children():
		spawnar_ghost()
	Atualizar_Ghost()
