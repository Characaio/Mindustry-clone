extends Node
class_name General_Information

var MapaDaGrid:Dictionary
var PosDoMouseNaGrid:Vector2

func _ready() -> void:
	pass
	
func pegar_grid() -> Dictionary:
	#print("minha grid: ", MapaDaGrid)
	return MapaDaGrid

func mudar_direção(direção) -> void:
	pass

func pegar_mouse() -> Vector2:
	return PosDoMouseNaGrid
	
func atualizar_mouse(posmouse:Vector2) -> void:
	PosDoMouseNaGrid = posmouse
	
func reescrever(Grid:Dictionary) -> void:
	MapaDaGrid = Grid
	
func mudar_grid(PosDoMouse,chave:Vector2,valor:Dictionary) -> void:

	MapaDaGrid[chave] = valor.duplicate(true)
	#print('general handle:' ,MapaDaGrid)
	atualizar_mouse(PosDoMouse)
