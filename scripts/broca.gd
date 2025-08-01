extends Bloco

class_name broca

@onready var label: Label = $Label
@export var animação_da_rotação: AnimationPlayer
@export var identificador_de_minerio: Sprite2D
#@onready var mechanical_drill_top_2: Sprite2D = $"Mechanical-drill-top-2"

var GridDosOre1:Dictionary
var Quantidade:int
var TipoDeMinerio:Dictionary 
var dado_temp:Dictionary
var VelocidadeTotal:float
var MinerioMinerado:float
var info:Dictionary
@onready var timer: Timer = $Timer

var Estoque:Array

var dados: Dictionary

var VelocidadeBase:float
var Cores:Array[Color]
var Ghost:bool = true
var Interagiveis:Array[String] = ['Esteira','Nucleo']

func _process(delta: float) -> void:
	if timer.time_left <= 0 and not Ghost:
		print('Iniciei um timer')
		timer.start(1)
	
func _ready() -> void: 
	identificador_de_minerio.modulate = Color.from_rgba8(201,165,143)



func despejar_minerios() -> void:
	var mapadagrid =  GeneralInformation.pegar_grid()
	var Esteira:Array[Dictionary]
	var EsteiraIds:Array[Vector2]
	var novo:Vector2
	
	var Direções:Array[Vector2] = [
		Vector2.LEFT,
		Vector2.DOWN,
		Vector2.UP,
		Vector2.RIGHT
	]
	print('Id: ', Id)
	for id in Id:
		#print('Id: ',id)
		for dir in Direções:
			novo = id + dir
			if novo not in Id:
				if mapadagrid.has(novo):
					var grid = mapadagrid[novo]
					if grid['tipo_de_bloco'] in Interagiveis and grid['estoque_da_esteira'].size() <  grid['limite_da_esteira']:
						print("ta dboa, pode passar")
						EsteiraIds.append(novo)
					else:
						print("vish karai, a esteira: ", novo, ' ta cheia, pode passar la nn mano')
	
	print('ID das esteiras: ', EsteiraIds)
	if not EsteiraIds.is_empty():
		var aleatorio:Vector2 = EsteiraIds.pick_random()
		print('Esteira escolhida esta no: ', aleatorio)
		
		GeneralInformation.mudar_item_especifico(aleatorio,'estoque_da_esteira',melhor_minerio)
		Estoque.pop_back()
		Informação = str('Minerio: ',melhor_minerio, ' Quantidade: ',Quantidade, ' Estoque: ', Estoque)
		label.text = Informação
	else:
		pass
var Informação:String
var melhor_prioridade = -1
var melhor_minerio 
var values:Array

func verificar_minerios() -> void:
	melhor_prioridade = -1
	melhor_minerio = ''
	values.clear()
	GridDosOre1 = GeneralInformation.pegar_grid_dos_ores()
	Quantidade = 0
	TipoDeMinerio.clear()
	
	print('Minerios: ',Ore.pegar_minerios())

	
	for id in Id:
		var valor = GeneralInformation.pegar_item_especifico_dos_minerios(id)
		print('Id: ',id, 'Item: ',valor)
		if valor != {}:
			valor['Quantidade'] += 1
			info[id] = valor
			
	print('Info: ', info)
	
	print('Maximo: ',info.values().max())
	
	values.clear()
	for item in info.values():
		values.append(item['Prioridade'])
		
	print('values ', values)
	
	for item in info.values():
		if values.size() >= 0:
			if values.max() == values.min():
				#print('AS PRIORIDADES, SÃO, IGUAISSSSSS')
				melhor_minerio = item['Nome']
				melhor_prioridade = item['Prioridade']
			else:
				#print('As prioridades são diferentes')
				print('Minerio Detectado: ', item['Nome'])
				if item['Prioridade'] > melhor_prioridade:
					melhor_prioridade = item['Prioridade']
					melhor_minerio = item['Nome']
		
	for sla in info.values():
		if sla['Nome'] == melhor_minerio:
			Quantidade += 1
		
	print('Minerio: ',melhor_minerio , ' Prioridade: ', melhor_prioridade)
	
	Informação = str('Minerio: ',melhor_minerio, ' Quantidade: ',Quantidade, ' Estoque: ', Estoque)
	label.text = Informação
	print('Temos ', Quantidade, ' de ',melhor_minerio)
	for minerio in Ore.pegar_minerios():
		#print('mineriozinzon: ', minerio)
		if minerio['Nome'] == melhor_minerio:
			#print('OPA, AI É BRABO')
			identificador_de_minerio.modulate = minerio['Cor']
	VelocidadeBase *= Quantidade
	
func descobrir_dados(Escolha:Dictionary) -> void:
	print('tamanhoX: ',Escolha['tamanhox'] )
	print('tamanhoY: ',Escolha['tamanhoy'] )
	dados['tamanhox'] = Escolha['tamanhox']
	dados['tamanhoy'] = Escolha['tamanhoy']
	dados['Nome'] = Escolha['nome']

	if dados['Nome'] == 'Broca':
		VelocidadeBase = 0.10
	if dados['Nome'] == 'Broca Pneumatica':
		VelocidadeBase = 0.78
	
func começar_animação() -> void:
	Ghost = false
	animação_da_rotação.play("rotação")


func _on_timer_timeout() -> void:
	MinerioMinerado += VelocidadeBase
	#print('UI, AUMENTEI, UAU: ', MinerioMinerado)
	while MinerioMinerado > 1:
		print('UI, minerei um ', melhor_minerio)
		if Estoque.size() <= 1:
			animação_da_rotação.play("rotação")
			Estoque.append(melhor_minerio)
			print('Meu Estoque é: ', Estoque)
			
			Informação = str('Minerio: ',melhor_minerio, ' Quantidade: ',Quantidade, ' Estoque: ', Estoque)
			label.text = Informação
		else:
			print('AAAAAAAAAAA, TO CHEIO PORRA')
			animação_da_rotação.stop()
		MinerioMinerado -= 1
		despejar_minerios()
