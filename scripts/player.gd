extends CharacterBody2D

var SPEED:int = 500
@onready var player_2: Sprite2D = $Player2
@onready var player: CharacterBody2D = $"."
@onready var label: Label = $"../Label"

@onready var musicas: Node = $"../musicas"

@onready var bottom_tile_map: TileMapLayer = $"../Tiles/Bottom TileMap"
@onready var mid_tile_map: TileMapLayer = $"../Tiles/Mid TileMap"
@onready var player_tile_map: TileMapLayer = $"../Tiles/Player TileMap"
@onready var top_tile_map: TileMapLayer = $"../Tiles/Top TileMap"


var AnguloDesejado:float
var AnguloAtual:float
var MouseGlobal:Vector2
var MouseLocal:Vector2
var GridXDoMouse:int
var GridYDoMouse:int

var Escolha:int = 0

var BlocosDoisPorDois = [1,4]
var BlcosTresPorTres = [3]
@onready var camera_2d: Camera2D = $Camera2D

var MapaLogico = {'tipo':'PrensaDeGrafite'}

var PrensaDeGrafite:int = 1
var Esteira:int = 2
var Nucleo:int = 3
var Broca:int = 4

var tile1
var ZoomAtual:Vector2
var ZoomFuturo:Vector2

func _ready() -> void:
	ZoomAtual = camera_2d.zoom
	ZoomFuturo = camera_2d.zoom


func _process(delta: float) -> void:
	pass
	

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			if ZoomFuturo < Vector2(1.45,1.45):
				ZoomFuturo += Vector2(0.1,0.1)
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			if ZoomFuturo > Vector2(0.65,0.65):
				ZoomFuturo -= Vector2(0.1,0.1)
			
			
var VectorAntigo:Vector2
var pressed:bool = false

func _physics_process(delta: float) -> void:
	var direction : Vector2 = Input.get_vector("esquerda",'direita','cima','baixo').normalized()
	ZoomAtual = camera_2d.zoom
	camera_2d.zoom = lerp(ZoomAtual,ZoomFuturo, 0.05)
	velocity = direction * SPEED
	
	label.position = position
	label.text = str('atual:',rotation, "\n", "desejado:",direction.angle())
	
	if Input.is_action_pressed('m1'):
		look_at(get_global_mouse_position())
		pressed = true
	else:
		pressed = false
	if direction != Vector2.ZERO:
		VectorAntigo = direction
	if not pressed:
		
		rotation = lerp_angle(rotation,VectorAntigo.angle(),0.1)
	move_and_slide()
