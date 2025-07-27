extends Bloco

class_name broca

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label: Label = $Label

var GridDosOre1:Dictionary
var Quantidade:int
var TipoDeMinerio:Dictionary 
var dado_temp:Dictionary
var VelocidadeTotal:float

var info:Dictionary

var dados: Dictionary

var VelocidadeBase:float

func _ready() -> void: 
	pass

func minerar_minerio():
	VelocidadeTotal = VelocidadeBase * Quantidade

func verificar_minerios() -> void:
	GridDosOre1 = GeneralInformation.pegar_grid_dos_ores()
	Quantidade = 0
	TipoDeMinerio.clear()
	for chave in GridDosOre1.keys():
		info[GridDosOre1[chave]['Nome']] = 0
	
	for chave in GridDosOre1.keys():
		if chave in Id:
			info[GridDosOre1[chave]['Nome']] += 1
			TipoDeMinerio = info
	for chave in info.keys():
		if info[chave] == 0:
			info.erase(chave)
			
			
	print('quantidade: ', Quantidade)
	print('TipoDeMinerio: ', TipoDeMinerio)
	label.text = str(TipoDeMinerio)

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
