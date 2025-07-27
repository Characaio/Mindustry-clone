extends Bloco

class_name broca

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label: Label = $Label

@onready var mechanical_drill_top_2: Sprite2D = $"Mechanical-drill-top-2"

var GridDosOre1:Dictionary
var Quantidade:int
var TipoDeMinerio:Dictionary 
var dado_temp:Dictionary
var VelocidadeTotal:float

var info:Dictionary

var dados: Dictionary

var VelocidadeBase:float
var quantidade:int
var Cores:Array[Color]

func _ready() -> void: 
	mechanical_drill_top_2.modulate = Color.from_rgba8(201,165,143)

func minerar_minerio():
	VelocidadeTotal = VelocidadeBase * Quantidade

func verificar_minerios() -> void:
	GridDosOre1 = GeneralInformation.pegar_grid_dos_ores()
	Quantidade = 0
	TipoDeMinerio.clear()
	var valor
	print('Minerios: ',Ore.pegar_minerios())
	
	for id in Id:
		valor = GeneralInformation.pegar_item_especifico_dos_minerios(id)
		print('Id: ',id, 'Item: ',valor)
		if valor != {}:
			valor['Quantidade'] += 1
			info[id] = valor
			
	print('Info: ', info)
	
	for karai in info.values():
		print('Karai: ', karai)
		if karai['Nome'] == 'Thorium':
			Quantidade += karai['Quantidade']
	print('quantidade: ', Quantidade)
	print('TipoDeMinerio: ', TipoDeMinerio)
	label.text = str(TipoDeMinerio)
	if info.has('Cor'):
		mechanical_drill_top_2.modulate = info['Cor']
		
func descobrir_dados(Escolha:Dictionary) -> void:
	print('tamanhoX: ',Escolha['tamanhox'] )
	print('tamanhoY: ',Escolha['tamanhoy'] )
	dados['tamanhox'] = Escolha['tamanhox']
	dados['tamanhoy'] = Escolha['tamanhoy']
	dados['Nome'] = Escolha['nome']

	if dados['Nome'] == 'Broca':
		VelocidadeBase = 0.36
	
func começar_animação() -> void:
	animation_player.play("rotação")
