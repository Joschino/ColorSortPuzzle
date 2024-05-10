extends Node2D

var solved := false

@export var size = 3
@export var columnTop : Texture2D
@export var columMiddle : Texture2D
@export var columnBottom : Texture2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var top = Sprite2D.new()
	top.texture = columnTop
	add_child(top)
	for i in size-2:
		print(i)
		var middle = Sprite2D.new()
		middle.texture = columMiddle
		middle.position = Vector2(0,256*(1+i))
		add_child(middle)
	var bottom = Sprite2D.new()
	bottom.texture = columnBottom
	bottom.position = Vector2(0,256*(size-1))
	add_child(bottom)

