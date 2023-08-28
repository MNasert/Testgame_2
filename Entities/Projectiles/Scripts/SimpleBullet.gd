extends Node2D

var speed: float
var damage: int
var hp: int
var penetrate_num:int
var range: float

func init(pos: Vector2, direction: Vector2, dmg: int, pierce: int):
	self.position = pos
	self.penetrate_num = pierce
	self.hp = 1 + pierce
	if direction.x < 0:
		$BulletAnim.flip_h = true
	self.movevec = direction * self.speed
	self.damage = dmg

func _ready():
	pass
	
func _process(delta):
	self.position += self.movevec * delta
	self.travel_dist += self.speed * delta
	if self.travel_dist > self.range:
		self.queue_free()
	if self.hp <= 0:
		self.set_process(false)
		$Area2D/CollisionShape2D.disabled = true
		$BulletAnim.play("default")

func _on_bullet_anim_animation_finished():
	self.queue_free()

