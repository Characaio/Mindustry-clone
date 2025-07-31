extends Node
class_name General_Information

var MapaDaGrid:Dictionary
var PosDoMouseNaGrid:Vector2
var MapaDaGridOres:Dictionary
var Estoque:Array

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

func pegar_estoque(id:Array[Vector2]) -> Array:
	#print(MapaDaGrid[id[0]]['estoque_da_esteira'])
	#print( MapaDaGrid[id[0]]['estoque_da_esteira'])
	return MapaDaGrid[id[0]]['estoque_da_esteira']

func deletar_item_da_grid(chave:Vector2) -> void:
	MapaDaGrid.erase(chave)
	
#func pegar_progresso_da_grid(chavedagrid:Vector2) -> float:
	#return MapaDaGrid[chavedagrid]['estoque_da_esteira'][1]
	
func mudar_progresso_da_grid(chavedagrid:Vector2, progresso:float) -> void:
	MapaDaGrid[chavedagrid]['estoque_da_esteira'][0][1] = progresso

func mudar_item_especifico(ChaveDaGrid:Vector2,ChaveInterna:String,valor,SuaEsteira:bool = true) -> void:
	var AcessoDaGrid:Dictionary = MapaDaGrid[ChaveDaGrid]
	if valor in Ore.pegar_nome_de_minerios():
		Estoque = pegar_estoque([ChaveDaGrid])
		Estoque.append(valor)
		AcessoDaGrid[ChaveInterna] = Estoque.duplicate(true)
		print('mudei esse baguio aqui ó: ',  ChaveDaGrid, ' Esse corno virou: ', MapaDaGrid[ChaveDaGrid][ChaveInterna])
		
func mudar_grid(chave:Vector2,valor:Dictionary) -> void:

	MapaDaGrid[chave] = valor.duplicate(true)
