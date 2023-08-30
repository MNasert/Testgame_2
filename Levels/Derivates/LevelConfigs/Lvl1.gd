extends Node2D

func _ready():
	pass

func _process(delta):
	pass

func _on_move_here_target_reached_target():
	get_tree().change_scene_to_file("res://MenuScreens/MainMenu.tscn")
