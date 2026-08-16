extends Node2D
var Rock = preload("res://Scenes/rock.tscn")

# todo load from a json
# todo add property for which sprite to load
var rock_data: Dictionary = {"id0":{"position":{"x":1, "y":1},  "value":10},
							 "id1":{"position":{"x":1, "y":0},  "value":15},
							 "id2":{"position":{"x":7, "y":15}, "value":10},
							 "id3":{"position":{"x":5, "y":5},  "value":1},
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for id in rock_data.keys():
		add_rock(Vector2(rock_data[id]["position"]["x"], rock_data[id]["position"]["y"]), rock_data[id]["value"])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	%playerscore.text = str(%Player.get_score())
	
func _draw():
	for x in range(0, 1152, Global.tileSize):
		draw_line(Vector2(x, 0), Vector2(x, 640), Color8(0, 0, 0), 1.5)
	for y in range(0, 640, Global.tileSize):
		draw_line(Vector2(0, y), Vector2(1152, y), Color8(0, 0, 0), 2)

func add_rock(position, score):	
	var rock = Rock.instantiate()
	rock.init(position, score)
	rock.picked_up.connect(%Player.pick_up)
	add_child(rock)


func _on_player_exploded(item) -> void:
	print("game over")
	print(item)
