extends Node2D
var Rock = preload("res://Scenes/rock.tscn")
var Compass = preload("res://scripts/compass.gd")
var compass

# todo load from a json
# todo add property for which sprite to load
var rock_data: Dictionary = {"id0":{"position":{"x":1, "y":1},  "value":10},
							 "id1":{"position":{"x":1, "y":0},  "value":15},
							 "id2":{"position":{"x":7, "y":15}, "value":10},
							 "id3":{"position":{"x":5, "y":5},  "value":1},
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# init compass
	compass = Compass.new()
	
	# init rocks
	var rocks: Array[Area2D] = []
	for id in rock_data.keys():
		rocks.append(add_rock(Vector2(rock_data[id]["position"]["x"], rock_data[id]["position"]["y"]), rock_data[id]["value"]))

	# update compass
	compass.add_targets(rocks)
	%Player.add_child(compass)

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
	rock.picked_up.connect(self.compass.remove_target) # hmm not sure I like this here
	add_child(rock)
	
	return rock


func _on_player_exploded(item) -> void:
	print("game over")
	print(item)
