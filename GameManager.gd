extends Node2D

@export var gameSize := 7
@export var column : PackedScene
@export var flowers : Array[Texture2D]
@export var flowerScene : PackedScene

func _ready() -> void:
	var width = get_viewport_rect().end.x
	var sizePerColumn = width / (gameSize+1)
	for i in gameSize:
		var newColumn : Node2D = column.instantiate()
		newColumn.position = Vector2(sizePerColumn * (1+i),200)
		newColumn.scale = Vector2(0.5,0.5)
		add_child(newColumn)

func RandomizeColors() -> void:
	for flowerTexture in flowers:
		for i in gameSize:
			var flower = flowerScene.instantiate()
			
