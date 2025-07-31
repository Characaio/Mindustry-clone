extends Node2D

var FrameAtual_da_esteira:int = 0
var QuantidadeDeFrames_da_esteira:int = 4
var delay_da_esteira:float = 0
var tempo_da_esteira: float = 0.1
var progresso:float = 0
var VelocidadeDaEsteira:float
var id:Array[Vector2]
#var FrameAtual_da_esteira:int = 0
#var QuantidadeDeFrames_da_esteira:int = 4
#var delay_da_esteira:float = 0
#var tempo_da_esteira: float = 0.1

func _process(delta: float) -> void:
	delay_da_esteira += delta
	if id:
		VelocidadeDaEsteira = GeneralInformation.pegar_grid()[id[0]]['velocidade_da_esteira']
		progresso = pegar_progresso(id)
		if progresso < 1:
			progresso += VelocidadeDaEsteira * delta
		if progresso >= 1:
			progresso = 0
	#print('frame atual: ',FrameAtual)
	if delay_da_esteira >= tempo_da_esteira:
		delay_da_esteira = 0
		FrameAtual_da_esteira = (FrameAtual_da_esteira+1) % QuantidadeDeFrames_da_esteira
	
		
func inicar_id(Id:Array[Vector2]) -> void:
	id =  Id

func pegar_progresso(Id:Array[Vector2]) -> float:
	return GeneralInformation.pegar_estoque(Id)[0][1]

func pegar_frame_atual_da_esteira() -> int:
	return FrameAtual_da_esteira
