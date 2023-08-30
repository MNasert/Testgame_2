extends Node2D

var target: Node2D = null

@export var speed: float = 0
@export var hp: float = 0
@export var damage: float = 0
@export var value: float = 0

func init(pos: Vector2):
	self.position = pos

func _ready():
	add_to_group("Enemies")

func move(delta):
	if self.target == null:
		self.target = get_tree().get_nodes_in_group("Player")[0]
		return
	var movevec = Vector2(self.target.position.x - self.position.x, 0).normalized()
	$Body.flip_h = movevec.x > 0 
	self.position += self.speed * movevec * delta

func _process(delta):
	self.move(delta)

func _on_area_2d_area_entered(area):
	var bullet = area.get_parent()
	if bullet not in get_tree().get_nodes_in_group("Projectiles"):
		return
	self.hp -= bullet.damage
	bullet.hp -= 1
	if self.hp <= 0:
		if bullet.fired_by != null:
			bullet.award_owner(self.value)
		self.queue_free()
