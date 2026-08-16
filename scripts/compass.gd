extends Node2D

# todo: parameters from json
# todo: proper logging

var cooldown : float = 1
var countdown: float = 0

var targets: Array[Area2D] = []
var selected_target: Area2D = null

var select_method: Callable
var show_method  : Callable

func _ready() -> void:
	self.select_method = self._get_nearest_target
	self.show_method   = self._display_as_text

func _process(delta: float) -> void:
	countdown = countdown-delta
	if countdown<=0.0:
		self.select_target()
		self.display()
		countdown = cooldown
	#print("Tracking ", self.targets.size(), " objects")

func add_target(target: Area2D) -> void:
	self.targets.append(target)

func add_targets(targets: Array[Area2D]) -> void:
	self.targets.append_array(targets)

func remove_target(target: Area2D) -> void:
	if self.targets.size() > 0:
		self.targets.erase(target)
		self.selected_target = null 

func remove_targets(targets: Array[Area2D]) -> void:
	for t in targets:
		self.remove_target(t)

func _get_nearest_target() -> Area2D:
	var target_min:Area2D
	var dist_min  :float = INF
	var dist_i    :float
	
	for i in self.targets.size():
		dist_i = self.global_position.distance_to(self.targets[i].global_position)
		if dist_i <= dist_min:
			dist_min   = dist_i
			target_min = self.targets[i]

	return target_min

func select_target():
	if self.targets.size() > 0:
		self.selected_target = self.select_method.call()

func _display_as_text() -> void:
	print("Tracking ", self.selected_target.global_position, " with distance ", self.global_position.distance_to(self.selected_target.global_position), " to ", self.global_position)

func display() -> void:
	if self.selected_target != null:
		self.show_method.call()
