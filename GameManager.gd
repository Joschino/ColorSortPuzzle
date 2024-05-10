extends Node2D

@export var gameSize := 8
@export var column : PackedScene
@export var flowers : Array[Texture2D]
@export var flowerScene : PackedScene

var columns : Array[Column]

func _ready() -> void:
	var width = get_viewport_rect().end.x
	var sizePerColumn = width / (gameSize+1)
	for i in gameSize:
		var newColumn : Column = column.instantiate()
		newColumn.position = Vector2(sizePerColumn * (1+i),200)
		newColumn.scale = Vector2(0.5,0.5)
		columns.append(newColumn)
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
			var column = columnsCopy[randi() % columnsCopy.size()]
			column.AddFlower(flower)
			if column.IsFull():
				columnsCopy.erase(column)
