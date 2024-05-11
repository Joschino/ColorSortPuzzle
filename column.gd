class_name Column
extends Node2D

var solved := false

@export var size = 3
@export var columnTop : Texture2D
@export var columMiddle : Texture2D
@export var columnBottom : Texture2D

const COLUMN_PART = preload("res://column_part.tscn")

var flowers : Array[Flower]
var flowerPositions : Array[Vector2]
var id : int

signal flowerSelected(flower : Flower)
signal solvedStateChanged(state : bool)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var top = COLUMN_PART.instantiate()
	top.get_node("Sprite2D").texture = columnTop
	top.Pressed.connect(OnPress)
	add_child(top)
	flowerPositions.push_front(Vector2(0,-16))
	flowerPositions.push_front(Vector2(0,110))
	for i in size-2:
		var middle = COLUMN_PART.instantiate()
		middle.get_node("Sprite2D").texture = columMiddle
		middle.position = Vector2(0,256*(1+i))
		middle.Pressed.connect(OnPress)
		flowerPositions.push_front(Vector2(0,110*(i*2+2)))
		flowerPositions.push_front(Vector2(0,110*(i*2+3)))
		add_child(middle)
	var bottom = COLUMN_PART.instantiate()
	bottom.get_node("Sprite2D").texture = columnBottom
	bottom.position = Vector2(0,256*(size-1))
	bottom.Pressed.connect(OnPress)
	flowerPositions.push_front(Vector2(0,110*(size*2-2)))
	flowerPositions.push_front(Vector2(0,110*(size*2-1)))
	add_child(bottom)

func AddFlower(flower : Flower) -> bool:
	if flowers.size() == size*2:
		return false
	flowers.push_front(flower)
	if flower.get_parent():
		flower.reparent(self)
	else:
		add_child(flower)
	flower.position = flowerPositions[flowers.size()-1]
	flower.visible = true
	CheckSolved()
	return true

func GetTopFlower() -> void:
	var flower = flowers.pop_front()
	print("flower %s" % flower)
	if flower:
		flowerSelected.emit(flower)
		flowers.erase(flower)
		flower.visible = false
	CheckSolved()

func IsFull() -> bool:
	return flowers.size() == size*2

func CheckSolved() -> void:
	if flowers.size() == 0:
		solvedStateChanged.emit(id,true)
		return
	var flowerColor = flowers[0].flowerName
	var count = 0
	for flower in flowers:
		print("flowerColor: %s == flower Color: %s" % [flowerColor,flower.flowerName])
		if flower.flowerName == flowerColor:
			count += 1
	print(count == size * 2 or count == 0)
	solvedStateChanged.emit(id,count == size * 2 or count == 0)

func OnPress() -> void:
	var flower = get_tree().root.get_node("Main").selectedFlower
	if flower:
		if AddFlower(flower):
			get_tree().root.get_node("Main").SetSelectedFlower(null)
	else:
		GetTopFlower()
