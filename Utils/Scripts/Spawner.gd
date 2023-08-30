extends Node2D

@export var Enemies: Array[PackedScene]
@export var numEnemiesPerType: Array[int]
@export var timeout_seconds: float

@onready var waveTimer = $Wavetimer
@onready var spawnTimer = $SpawnTimeout

var level
var enemyQueue: Array[Node2D] = []

func _ready():
	self.level = get_tree().get_root()
	self.waveTimer.start(1)

func generate_entities(type: PackedScene, num: int):
	for i in range(num):
		var e = type.instantiate()
		e.init(self.position)
		self.enemyQueue.append(e)
	
func _on_wavetimer_timeout():
	for enemyType in Enemies:
		for num_to_spawn in numEnemiesPerType:
			self.generate_entities(enemyType, num_to_spawn)
	self.spawnTimer.start(.1)
	self.waveTimer.start(self.timeout_seconds)
	
func _on_spawn_timeout_timeout():
	if len(self.enemyQueue) > 0:
		level.add_child(self.enemyQueue.pop_front())
	if len(self.enemyQueue) > 0:
		self.spawnTimer.start(1)
