extends Node2D

@onready var player_tile_map: TileMapLayer = $"../../Tiles/Player TileMap"

var PosDoMouseNaGrid:Vector2
var MapaDaGrid:Dictionary
var Escolha:Dictionary
var Escolha_primeira:String
var item
var ghost
var Rotação:int 
var PosDoTemp:Vector2

const CaminhoDosGhost:String = '../../Ghosting'
const CaminhoDasEstruturas:String = '../../Estruturas/'

const Inspecionar:Dictionary = {
	'id': -1
}

var MouseAntigo
var MouseNovo
func _ready() -> void:
	
	Escolha = Inspecionar
	

func teste() -> void:
	print('teste')

var temp:Array[Vector2]
var chilling:bool = false
var PosDaCelulaGlobal:Vector2
var PosDaCelulaLocal:Vector2

func handle_click() -> void:
	
	temp.clear()
	print('temp: ',temp)
	
	for x in range(Escolha['tamanhox']):
		for y in range(Escolha['tamanhoy']):
			print('sla karaiiiii')
			PosDaCelulaLocal = Vector2(x,y)
			if Escolha['tamanhox'] == 3:
				PosDaCelulaGlobal= PosDoMouseNaGrid + PosDaCelulaLocal + Vector2(-1,-1)
			else:
				PosDaCelulaGlobal = PosDoMouseNaGrid + PosDaCelulaLocal
			temp.append(PosDaCelulaGlobal)
			
			if Escolha['tipo_de_bloco'] == 'Broca':
				for chave in temp:
					if not chilling:
						if GeneralInformation.pegar_grid_dos_ores().has(chave):
							chilling = true
						else:
							chilling = false
			else:
				chilling = true
				
			if MapaDaGrid.has(PosDaCelulaGlobal):
				print('fudeu1')
				if MapaDaGrid[PosDaCelulaGlobal]['tipo_de_bloco'] != 'Esteira':
					chilling = false
	if chilling:
		for chave in temp:
			GeneralInformation.mudar_grid(PosDoMouseNaGrid,chave,Escolha)
		print('to zen')
		spawnar_bloco()
		
	else:
		for node:Node2D in get_node(CaminhoDosGhost).get_children():
			node.modulate = Color.from_rgba8(255,140,125,125)
			
		print('fudeu2')

func handle_replacement() -> void:
	for node:Bloco in get_node(CaminhoDasEstruturas).get_children():
		if PosDoMouseNaGrid in node.pegar_Id():
			node.deletar()
			handle_click()
			
			
func spawnar_bloco() -> void:
	item = Escolha['cena'].instantiate()
	item.atualizar_id(temp)
	item.position = player_tile_map.map_to_local(PosDoMouseNaGrid)

	get_node(CaminhoDasEstruturas).add_child(item)
	
	if item.has_method('identificar_lados'):
		print('Mapa da grid: ', MapaDaGrid)
		print('PosMouse: ', PosDoMouseNaGrid)
		#print("Especifico: ",MapaDaGrid[PosDoMouseNaGrid])
		MapaDaGrid[PosDoMouseNaGrid]['direção'] = Rotação
		item.rotação = Rotação
		GeneralInformation.reescrever(MapaDaGrid)
		item.identificar_lados()
		item.arrow.visible = false
	
	if item.has_method('começar_animação'):
		item.começar_animação()
		item.descobrir_dados(Escolha)
		item.verificar_minerios()
		
		
func Atualizar_Ghost() -> void:
	for node:Node2D in get_node(CaminhoDosGhost).get_children():
		if node.has_method('rotacionar_ghost'):
			node.rotacionar_ghost(Rotação)
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
	if Input.is_action_just_pressed('m1'):
		if Escolha != Inspecionar:
			if MapaDaGrid.has(PosDoMouseNaGrid):
				if MapaDaGrid[PosDoMouseNaGrid]['tipo_de_bloco'] == 'Esteira':
					handle_replacement()
				else:
					print('ja tem baguio')
			else:
				handle_click()
		else:
			print('posição do mouse: ', PosDoMouseNaGrid)
			if MapaDaGrid.has(PosDoMouseNaGrid):
				print('dados da celula: ', MapaDaGrid[PosDoMouseNaGrid])
				
	if Input.is_action_just_pressed('m2'):
		if MapaDaGrid.has(PosDoMouseNaGrid):
			MapaDaGrid.erase(PosDoMouseNaGrid)
			for estruturinha in get_node(CaminhoDasEstruturas).get_children():
				if estruturinha.name != 'Ghosting':
					if estruturinha.verificar(PosDoMouseNaGrid):
						estruturinha.deletar()
				
			
	if Input.is_action_just_pressed("0"):
		limpar_baguios()
		Escolha_primeira = 'Inspecionar'
		
	if Input.is_action_just_pressed('1'):
		limpar_baguios()
		Escolha_primeira = 'Prensa_De_Grafite'
		
	if Input.is_action_just_pressed('2'):
		limpar_baguios()
		Escolha_primeira = 'Esteira'
		
	if Input.is_action_just_pressed('3'):
		limpar_baguios()
		Escolha_primeira = 'Nucleo'
		
	if Input.is_action_just_pressed('4'):
		limpar_baguios()
		Escolha_primeira = 'Broca'
	
	Escolha = TileDataBase.get_tile(Escolha_primeira)
	
	if Input.is_action_just_pressed('r'):
		if Escolha.has('Rotacional'):
			print('ain, rotacioneiii')
			Rotação += 90
			if Rotação == 360:
				Rotação = 0
			print(Rotação)
			
	
		
	if not get_node(CaminhoDosGhost).get_children():
		spawnar_ghost()
	Atualizar_Ghost()
