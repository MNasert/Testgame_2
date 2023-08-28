extends Button

@export var Scene: PackedScene = null
@export var ScenePath: String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_pressed():
	if self.Scene != null:
		get_tree().change_scene_to_packed(self.Scene)
	elif self.ScenePath != "":
		get_tree().change_scene_to_file(self.ScenePath)
	else:
		get_tree().quit(0)
