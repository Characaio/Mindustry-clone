extends Node2D

var FrameAtual:int = 0

var QuantidadeDeFrames:int = 4
var delay:float = 0
var tempo: float = 0.1

func _process(delta: float) -> void:
	delay += delta
	#print('frame atual: ',FrameAtual)
	if delay >= tempo:
		delay = 0
		FrameAtual = (FrameAtual+1) % QuantidadeDeFrames
		
	

func pegar_frame_atual() -> int:
	return FrameAtual
