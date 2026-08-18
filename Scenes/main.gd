extends Node2D
var Rock = preload("res://Scenes/rock.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_rock(Vector2(1,1), 10)
	add_rock(Vector2(1,0), 15)
	add_rock(Vector2(7,15), 10)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	%playerscore.text = str(%Player.get_score())
	
func _draw():
	for x in range(0, 1152, Global.tileSize):
		draw_line(Vector2(x, 0), Vector2(x, 640), Color8(0, 0, 0), 1.5)
	for y in range(0, 640, Global.tileSize):
		draw_line(Vector2(0, y), Vector2(1152, y), Color8(0, 0, 0), 2)

func add_rock(startPos, score):	
	var rock = Rock.instantiate()
	rock.init(startPos, score, Global.tileSize)
	rock.picked_up.connect(%Player.pick_up)
	add_child(rock)


func _on_player_exploded(item) -> void:
	print("game over")
	print(item)
