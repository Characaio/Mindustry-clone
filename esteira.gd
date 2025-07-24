extends Node2D
class_name esteira

var ID:Vector2
@onready var esteira_root: esteira = $"."

@onready var down_right: AnimatedSprite2D = $"ESTEIRA4/DOWN-RIGHT"
@onready var down_left: AnimatedSprite2D = $"ESTEIRA4/DOWN-LEFT"
@onready var up_left: AnimatedSprite2D = $"ESTEIRA4/UP-LEFT"
@onready var up_right: AnimatedSprite2D = $"ESTEIRA4/UP-RIGHT"
@onready var right_down: AnimatedSprite2D = $"ESTEIRA4/RIGHT-DOWN"
@onready var right_up: AnimatedSprite2D = $"ESTEIRA4/RIGHT-UP"
@onready var left_down: AnimatedSprite2D = $"ESTEIRA4/LEFT-DOWN"
@onready var left_up: AnimatedSprite2D = $"ESTEIRA4/LEFT-UP"






@onready var conveyor: Sprite2D = $Conveyor
@onready var conveyor_0: AnimatedSprite2D = $conveyor0
@onready var conveyor_1: AnimatedSprite2D = $conveyor1
@onready var conveyor_2: AnimatedSprite2D = $conveyor2
@onready var conveyor_3: AnimatedSprite2D = $conveyor3
@onready var conveyor_4: AnimatedSprite2D = $conveyor4
@onready var arrow: Sprite2D = $"Place-arrow"

var EsteiraAtual:AnimatedSprite2D

var SouGhost:bool = true

var rotação:int
var LadoDeTras:Vector2
var LadoDaFrente:Vector2

var Interagiveis:Array[String] = ['Broca','Fabrica']


var lados:Dictionary = {
	'cima': false,
	'baixo': false,
	'direita': false,
	'esquerda': false
}

var cima:Vector2
var baixo:Vector2
var direita:Vector2
var esquerda:Vector2

var Esteira:Dictionary

var PosDoMouseNaGrid: Vector2
var MapaDaGrid:Dictionary

func _ready() -> void:
	EsteiraAtual = conveyor_0
	PosDoMouseNaGrid = GeneralInformation.pegar_mouse()
	cima = PosDoMouseNaGrid + Vector2.UP
	baixo = PosDoMouseNaGrid + Vector2.DOWN
	direita = PosDoMouseNaGrid + Vector2.RIGHT
	esquerda = PosDoMouseNaGrid + Vector2.LEFT
	
	direções = [cima,baixo,direita,esquerda]

var updated:bool

func _process(delta: float) -> void:
	rotation_degrees = rotação
	MapaDaGrid = GeneralInformation.pegar_grid()
	PosDoMouseNaGrid = GeneralInformation.pegar_mouse()
	if MapaDaGrid.has(PosDoMouseNaGrid):
		Esteira = MapaDaGrid[PosDoMouseNaGrid].duplicate(true)
		Esteira['direção'] = rotação
	if not SouGhost:
		EsteiraAtual.frame = FrameHandler.pegar_frame_atual()
		decidir_sprite()
	
func decidir_lados() -> void:
	if rotation_degrees == 0:#apontado para direita
		LadoDaFrente = Vector2.RIGHT
		LadoDeTras = Vector2.LEFT
	if rotation_degrees == 90:#apontado para baixo
		LadoDaFrente = Vector2.DOWN
		LadoDeTras = Vector2.UP
	if rotation_degrees == 180:#apontado para esquerda
		LadoDaFrente = Vector2.LEFT
		LadoDeTras = Vector2.RIGHT
	if rotation_degrees == 270:#apontado para cima
		LadoDaFrente = Vector2.UP
		LadoDeTras = Vector2.DOWN
	
#func verificar_vizinhos() -> void:
	#if MapaDaGrid.has(baixo):
		#lados['baixo'] = true
		#relatorio(baixo,'abaixo')
	#if MapaDaGrid.has(cima):
		#lados['cima'] = true
		#relatorio(cima,'acima')
	#if MapaDaGrid.has(direita):
		#lados['direita'] = true
		#relatorio(direita,'a direita')
	#if MapaDaGrid.has(esquerda):
		#lados['esquerda'] = true
		#relatorio(esquerda,'a esquerda')

func rotacionar_ghost(dire) -> void:
	rotação = dire
	
func decidir_sprite() -> void:
	#verificar_vizinhos()
	decidir_lados()
	
	EsteiraAtual.visible = false
	
	if LadoDaFrente == Vector2.RIGHT:
		if MapaDaGrid.has(cima):
			if MapaDaGrid[cima]['direção'] == 90:
				rotation_degrees = 0
				EsteiraAtual = down_right
		if MapaDaGrid.has(baixo):
			if MapaDaGrid[baixo]['direção'] == 270:
				rotation_degrees = 0
				EsteiraAtual = up_right
				
	if LadoDaFrente == Vector2.UP:
		if MapaDaGrid.has(esquerda):
			if MapaDaGrid[esquerda]['direção'] == 0:
				rotation_degrees = 0
				EsteiraAtual = right_up
		if MapaDaGrid.has(direita):
			if MapaDaGrid[direita]['direção'] == 180:
				rotation_degrees = 0
				EsteiraAtual = left_up
				
	if LadoDaFrente == Vector2.LEFT:
		if MapaDaGrid.has(baixo):
			if MapaDaGrid[baixo]['direção'] == 270:
				rotation_degrees = 0
				EsteiraAtual = up_left
		if MapaDaGrid.has(cima):
			if MapaDaGrid[cima]['direção'] == 90:
				rotation_degrees = 0
				EsteiraAtual = down_left
				
	if LadoDaFrente == Vector2.DOWN:
		if MapaDaGrid.has(esquerda):
			if MapaDaGrid[esquerda]['direção'] == 0:
				rotation_degrees = 0
				EsteiraAtual = right_down
		if MapaDaGrid.has(direita):
			if MapaDaGrid[direita]['direção'] == 180:
				rotation_degrees = 0
				EsteiraAtual = left_down
		#for lado in lados.values():
			#pass
	EsteiraAtual.visible = true

var direções:Array[Vector2]

func identificar_lados() -> void:
	ID = GeneralInformation.pegar_mouse()
	#print('mapa da grid: ', MapaDaGrid)

	conveyor.visible = false
	EsteiraAtual.visible = true
	SouGhost = false
	decidir_lados()
	
	
	
	for direção in direções:
		if MapaDaGrid.has(direção):
			print('posição ',direção, ' valor: ', MapaDaGrid[direção])
			
	var chaves = MapaDaGrid.keys()
	#print('chaves: ', MapaDaGrid.keys())
	EsteiraAtual.visible = true
	
	relatorio(PosDoMouseNaGrid,'que esta em')

func relatorio(direção:Vector2,nome_direção:String) -> void:
	pass
	#print('o tile ', nome_direção, ' ', direção, ' tem o bloco do tipo ', MapaDaGrid[direção]['tipo_de_bloco'], ' especificamente um bloco do tipo ', MapaDaGrid[direção]['nome'])
