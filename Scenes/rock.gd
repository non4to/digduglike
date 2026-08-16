extends Area2D
signal picked_up(item)
var score:int = 0



func init(startPos, value) -> void:
	self.position = startPos * Global.tileSize
	self.score = value
	
func _ready() -> void:
	pass
	
func _process(_delta: float) -> void:
	pass

func _on_area_entered(area: Area2D) -> void:
	if area.collision_layer==1:
		picked_up.emit(self)
		self.visible = false
		%CollisionShape2D.set_deferred("disabled", true)
