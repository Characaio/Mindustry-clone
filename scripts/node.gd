extends Node

@onready var bottom_tile_map: TileMapLayer = $"Tiles/Bottom TileMap"
@onready var ore_tile_map: TileMapLayer = $"Tiles/Ore TileMap"
@onready var player_tile_map: TileMapLayer = $"Tiles/Player TileMap"
@onready var decoration_tile_map: TileMapLayer = $"Tiles/Decoration TileMap"


var GramaParede = Vector2(0,0)
var TerraParede = Vector2(1,0)
var Grama = Vector2(2,0)

var mapa:Array = [
	[GramaParede,GramaParede,GramaParede,GramaParede,GramaParede,GramaParede,GramaParede,GramaParede],
	[GramaParede,GramaParede,GramaParede,GramaParede,Grama,Grama,Grama,Grama],
	[GramaParede,TerraParede,Grama,Grama,Grama,Grama,Grama,Grama],
	[TerraParede,TerraParede,Grama,Grama,Grama,Grama,Grama,Grama],
	[TerraParede,TerraParede,TerraParede,TerraParede,Grama,Grama,Grama,Grama]
]

var pos =  Vector2i(-1,-2)
var atlas_pos = Vector2i(4,1)




func _ready() -> void:
	

	var SlaKarai: Vector2i
	for x in range(20):
		for y in range(20):
			bottom_tile_map.set_cell(Vector2(x,y),0,Vector2(2,0))
	for x in range(mapa.size()):
		for y in range(mapa[x].size()):
			var local = Vector2(y,x)
			bottom_tile_map.set_cell(local,0,mapa[x][y])
	
