extends Bloco
class_name esteira


@onready var esteira_root: esteira = $"."

@onready var up_right: AnimatedSprite2D = $"ESTEIRA4/Up-Right"
@onready var up_left: AnimatedSprite2D = $"ESTEIRA4/Up-Left"
@onready var down_right: AnimatedSprite2D = $"ESTEIRA4/Down-Right"
@onready var down_left: AnimatedSprite2D = $"ESTEIRA4/Down-Left"
@onready var left_down: AnimatedSprite2D = $"ESTEIRA4/Left-Down"
@onready var left_up: AnimatedSprite2D = $"ESTEIRA4/Left-Up"
@onready var right_down: AnimatedSprite2D = $"ESTEIRA4/Right-Down"
@onready var right_up: AnimatedSprite2D = $"ESTEIRA4/Right-Up"



@onready var left_down_right: AnimatedSprite2D = $"ESTEIRA3/LeftDown-Right"
@onready var left_up_down: AnimatedSprite2D = $"ESTEIRA3/LeftUp-Down"
@onready var left_down_up: AnimatedSprite2D = $"ESTEIRA3/LeftDown-Up"
@onready var left_up_right: AnimatedSprite2D = $"ESTEIRA3/LeftUp-Right"
@onready var right_down_left: AnimatedSprite2D = $"ESTEIRA3/RightDown-Left"
@onready var right_up_left: AnimatedSprite2D = $"ESTEIRA3/RightUp-Left"
@onready var right_down_up: AnimatedSprite2D = $"ESTEIRA3/RightDown-Up"
@onready var right_up_down: AnimatedSprite2D = $"ESTEIRA3/RightUp-Down"


@onready var left_up_down_right: AnimatedSprite2D = $"ESTEIRA2/LeftUpDown-Right"
@onready var right_up_down_left: AnimatedSprite2D = $"ESTEIRA2/RightUpDown-Left"
@onready var right_left_up_down: AnimatedSprite2D = $"ESTEIRA2/RightLeftUp-Down"
@onready var right_left_down_up: AnimatedSprite2D = $"ESTEIRA2/RightLeftDown-Up"

@onready var convey: AnimatedSprite2D = $ESTEIRA1/CONVEY






@onready var conveyor: Sprite2D = $Conveyor
@onready var conveyor_0: AnimatedSprite2D = $conveyor0
@onready var conveyor_1: AnimatedSprite2D = $conveyor1
@onready var conveyor_2: AnimatedSprite2D = $ESTEIRA2/conveyor2
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
	Id = pegar_Id()
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

func rotacionar_ghost(dire) -> void:
	rotação = dire
	
var updat:bool = false
var ConfirmarDireita:bool
var ConfirmarEsquerda:bool
var ConfirmarCima:bool
var ConfirmarBaixo:bool

	
func decidir_sprite() -> void:
	#verificar_vizinhos()
	decidir_lados()
	
	if MapaDaGrid.has(esquerda):
		if MapaDaGrid[esquerda]['direção'] == 0:
			ConfirmarEsquerda = true
		else:
			ConfirmarEsquerda = false
	if MapaDaGrid.has(cima):
		if MapaDaGrid[cima]['direção'] == 90:
			ConfirmarCima = true
		else:
			ConfirmarCima = false
	
	if MapaDaGrid.has(direita):
		if MapaDaGrid[direita]['direção'] == 180:
			ConfirmarDireita = true
		else:
			ConfirmarDireita = false
			
	if MapaDaGrid.has(baixo):
		if MapaDaGrid[baixo]['direção'] == 270:
			ConfirmarBaixo = true
		else:
			ConfirmarBaixo = false
	EsteiraAtual.visible = false
	
	if LadoDaFrente == Vector2.RIGHT:
		if ConfirmarCima and ConfirmarBaixo and ConfirmarEsquerda:
			EsteiraAtual = left_up_down_right
		elif ConfirmarCima and ConfirmarBaixo:
			EsteiraAtual = convey
		elif ConfirmarCima and ConfirmarEsquerda:
			rotation_degrees = 0
			EsteiraAtual = left_up_right
		elif ConfirmarCima:
			rotation_degrees = 0
			EsteiraAtual = up_right
		elif ConfirmarBaixo and ConfirmarEsquerda:
			rotation_degrees = 0
			EsteiraAtual = left_down_right
		elif ConfirmarBaixo:
			rotation_degrees = 0
			EsteiraAtual = down_right

	if LadoDaFrente == Vector2.UP:
		
		if ConfirmarDireita and ConfirmarEsquerda and ConfirmarBaixo:
			EsteiraAtual = right_left_down_up
		elif ConfirmarDireita and ConfirmarEsquerda:
			EsteiraAtual = convey
		elif ConfirmarEsquerda and ConfirmarBaixo:
			rotation_degrees = 0
			EsteiraAtual = left_down_up
		elif ConfirmarEsquerda:
			rotation_degrees = 0
			EsteiraAtual = left_up
		elif ConfirmarDireita and ConfirmarBaixo:
			rotation_degrees = 0
			EsteiraAtual = right_down_up
		elif ConfirmarDireita:
			rotation_degrees = 0
			EsteiraAtual = right_up

	if LadoDaFrente == Vector2.LEFT:
		if ConfirmarDireita and ConfirmarCima and ConfirmarBaixo:
			EsteiraAtual = right_up_down_left
		elif ConfirmarCima and ConfirmarBaixo:
			EsteiraAtual = convey
		elif ConfirmarBaixo and ConfirmarDireita:
			rotation_degrees = 0
			EsteiraAtual = right_down_left
		elif ConfirmarBaixo:
			rotation_degrees = 0
			EsteiraAtual = down_left
		elif ConfirmarCima and ConfirmarDireita:
			rotation_degrees = 0
			EsteiraAtual = right_up_left
		elif ConfirmarCima:
			rotation_degrees = 0
			EsteiraAtual = up_left
		
	if LadoDaFrente == Vector2.DOWN:
		if ConfirmarDireita and ConfirmarEsquerda and ConfirmarCima:
			EsteiraAtual = right_left_up_down
		elif ConfirmarDireita and ConfirmarEsquerda:
			EsteiraAtual = convey
		elif ConfirmarEsquerda and ConfirmarCima:
			rotation_degrees = 0
			EsteiraAtual = left_up_down
		elif ConfirmarEsquerda:
			rotation_degrees = 0
			EsteiraAtual = left_down
		elif ConfirmarDireita and ConfirmarCima:
			rotation_degrees = 0
			EsteiraAtual = right_up_down
		elif ConfirmarDireita:
			rotation_degrees = 0
			EsteiraAtual = right_down

	EsteiraAtual.visible = true

var direções:Array[Vector2]


	
func identificar_lados() -> void:
	
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
