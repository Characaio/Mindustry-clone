extends Node2D
class_name Bloco

var Id:Array[Vector2]

func atualizar_id(Ids:Array[Vector2]) -> void:
	Id = Ids.duplicate(true)
	
func pegar_Id() -> Array[Vector2]:
	return Id
	
func verificar(posi) -> bool:
	if posi in Id:
		return true
	return false
	
func deletar() -> void:
	queue_free()
