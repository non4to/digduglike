extends Area2D
var score:int = 0

func init(startPos, score) -> void:
	self.position = startPos * Global.tileSize
	self.score = score
	
func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass

func _on_area_entered(area: Area2D) -> void:
	if area.collision_layer==1:
		area.inventory.append(self)
		self.visible = false
		%CollisionShape2D.set_deferred("disabled", true)
