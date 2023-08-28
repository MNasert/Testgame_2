extends Node2D

@export var Enemies: Array[PackedScene]
@export var numEnemiesPerType: Array[int]
@export var timeout_seconds: float

@onready var waveTimer = $Wavetimer

var level
# Called when the node enters the scene tree for the first time.
func _ready():
	self.level = get_tree().get_root()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
