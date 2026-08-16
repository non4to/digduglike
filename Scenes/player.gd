extends Area2D
signal exploded(item)

var inputs = {"ui_right": Vector2.RIGHT,
			"ui_left": Vector2.LEFT,
			"ui_up": Vector2.UP,
			"ui_down": Vector2.DOWN}
var inventory = []

# Called when the node enters the scene tree for the first time.
func _ready():
	position = position.snapped(Vector2.ONE * Global.tileSize)
	position += Vector2.ONE * Global.tileSize/2

func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)

func move(dir):
	position += inputs[dir] * Global.tileSize
			#inventory.append(collider)
			#collider.queue_free() 

func get_score():
	var score = 0
	for rock in self.inventory:
		score += rock.score
	return score

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

#func picked_up_something(obj):
	#self.inventory.append(obj)
	
func pick_up(item):
	for rock in inventory:
		if rock.score == item.score:
			exploded.emit(item)
	self.inventory.append(item)
