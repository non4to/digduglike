extends Node2D

const height:int = 5
const width:int  = 5
var map:Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(height):
		map.append([])
		for j in range(width):
			map[i].append("")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
