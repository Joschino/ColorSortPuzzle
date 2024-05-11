extends Node2D

@export var gameSize := 8
@export var column : PackedScene
@export var flowers : Array[Texture2D]
@export var flowerScene : PackedScene

var columns : Array[Column]
var selectedFlower : Flower
@onready var flowerSprite: Sprite2D = $Sprite2D
var solvedState : Array[bool]
@onready var game_ui: Control = $CanvasLayer/GameUI

func _ready() -> void:
	var width = get_viewport_rect().end.x
	var sizePerColumn = width / (gameSize+1)
	for i in gameSize:
		solvedState.append(false)
		var newColumn : Column = column.instantiate()
		newColumn.position = Vector2(sizePerColumn * (1+i),200)
		newColumn.scale = Vector2(0.5,0.5)
		newColumn.id = i
		columns.append(newColumn)
		newColumn.flowerSelected.connect(SetSelectedFlower)
		newColumn.solvedStateChanged.connect(SetSolved)
		add_child(newColumn)
	RandomizeColors()

func RandomizeColors() -> void:
	var columnsCopy : Array[Column]
	columnsCopy = columns
	print(columns.size())
	print(columnsCopy.size())
	columnsCopy.erase(columnsCopy[randi() % columnsCopy.size()])
	columnsCopy.erase(columnsCopy[randi() % columnsCopy.size()])
	for flowerTexture in flowers:
		for i in 4:
			var flower : Sprite2D = flowerScene.instantiate()
			flower.texture = flowerTexture
			print(flowerTexture.resource_path.split("/")[-1])
			flower.flowerName = flowerTexture.resource_path.split("/")[-1]
			var column = columnsCopy[randi() % columnsCopy.size()]
			column.AddFlower(flower)
			if column.IsFull():
				columnsCopy.erase(column)

func SetSelectedFlower(flower : Flower) -> void:
	selectedFlower = flower
	print("Selected flower: %s" % selectedFlower)
	if flower:
		flowerSprite.texture = selectedFlower.texture
	else:
		flowerSprite.texture = null

func SetSolved(id : int, state : bool) -> void:
	solvedState[id] = state
	print(solvedState)
	for value in solvedState:
		if !value:
			return
	game_ui.visible = true
