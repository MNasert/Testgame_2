extends Node2D

signal reached_target

func _ready():
	pass

func _process(delta):
	pass

func _on_area_2d_area_entered(area):
	var entity = area.get_parent()
	if entity not in get_tree().get_nodes_in_group("Player"):
		return
	self.emit_signal("reached_target")
