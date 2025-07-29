extends Node
class_name General_Information

var MapaDaGrid:Dictionary
var PosDoMouseNaGrid:Vector2
var MapaDaGridOres:Dictionary


func _ready() -> void:
	pass

func pegar_grid() -> Dictionary:
	return MapaDaGrid

func pegar_grid_dos_ores() -> Dictionary:
	return MapaDaGridOres

func pegar_item_especifico_dos_minerios(posição) -> Dictionary:
	if MapaDaGridOres.has(posição):
		return MapaDaGridOres[posição].duplicate(true)
	return {}
func pegar_mouse() -> Vector2:
	return PosDoMouseNaGrid

func atualizar_mouse(posmouse:Vector2) -> void:
	PosDoMouseNaGrid = posmouse

func reescrever(Grid:Dictionary) -> void:
	MapaDaGrid = Grid

func colocar_minerios(chave:Vector2,valor:Dictionary) -> void:
	MapaDaGridOres[chave] = valor.duplicate(true)

func deletar_item_da_grid(chave:Vector2) -> void:
	MapaDaGrid.erase(chave)

func mudar_item_especifico(ChaveDaGrid:Vector2,ChaveInterna:String,valor:String) -> void:
	if valor == '+1':
		if MapaDaGrid[ChaveDaGrid][ChaveInterna] < MapaDaGrid[ChaveDaGrid]['limite_da_esteira']:
			MapaDaGrid[ChaveDaGrid][ChaveInterna] += 1
		else:
			print("TO CHEIO CHEFE: ", ChaveDaGrid)
func mudar_grid(chave:Vector2,valor:Dictionary) -> void:

	MapaDaGrid[chave] = valor.duplicate(true)
