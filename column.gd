class_name Column
extends Node2D

var solved := false

@export var size = 3
@export var columnTop : Texture2D
@export var columMiddle : Texture2D
@export var columnBottom : Texture2D

var flowers : Array[Flower]
var flowerPositions : Array[Vector2]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var top = Sprite2D.new()
	top.texture = columnTop
	add_child(top)
	flowerPositions.push_front(Vector2(0,-16))
	flowerPositions.push_front(Vector2(0,110))
	for i in size-2:
		var middle = Sprite2D.new()
		middle.texture = columMiddle
		middle.position = Vector2(0,256*(1+i))
		flowerPositions.push_front(Vector2(0,110*(i*2+2)))
		flowerPositions.push_front(Vector2(0,110*(i*2+3)))
		add_child(middle)
	var bottom = Sprite2D.new()
	bottom.texture = columnBottom
	bottom.position = Vector2(0,256*(size-1))
	flowerPositions.push_front(Vector2(0,110*(size*2-2)))
	flowerPositions.push_front(Vector2(0,110*(size*2-1)))
	add_child(bottom)

func AddFlower(flower : Flower) -> bool:
	if flowers.size() == 8:
		return false
	flowers.push_front(flower)
	add_child(flower)
	flower.position = flowerPositions[flowers.size()-1]
	return true

func GetTopFlower() -> Flower:
	return flowers.pop_front()

func IsFull() -> bool:
	return flowers.size() == size*2
