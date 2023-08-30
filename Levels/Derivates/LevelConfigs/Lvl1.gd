extends Node2D

func _ready():
	pass

func _process(delta):
	pass

func _on_move_here_target_reached_target():
	for child in get_tree().get_root().get_children():
		child.queue_free()
	get_tree().change_scene_to_file("res://MenuScreens/MainMenu.tscn")
