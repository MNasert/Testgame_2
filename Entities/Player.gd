extends Node2D

@export var speed: float = 0
@export var firerate: float = 0  # shots/s
@export var damage: int = 0
@export var hp: int = 0
@export var pierce: int = 0


@export var bullet: PackedScene

var can_shoot = true
var firerate_cooldown: float
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Player")
	$Body.play("default")

func get_inputs() -> Array[bool]:
	var inputs: Array[bool] = [0, 0, 0, 0, 0]
	if Input.is_action_pressed("up"):
		inputs[0] = 1
	if Input.is_action_pressed("down"):
		inputs[1] = 1
	if Input.is_action_pressed("left"):
		inputs[2] = 1
	if Input.is_action_pressed("right"):
		inputs[3] = 1
	if Input.is_action_pressed("shoot"):
		inputs[4] = 1
	return inputs

func move(inputs: Array[bool], delta: float):
	var movevec = Vector2(0, 0)
	if inputs[2]:
		movevec.x += -1
		$Body.flip_h = true
	if inputs[3]:
		movevec.x += 1
		$Body.flip_h = false
	self.position += movevec * self.speed * delta

func shoot(inputs: Array[bool]):
	if not inputs[4]:
		return
	if not self.can_shoot:
		return
	var new_bullet = self.bullet.instantiate()
	new_bullet.init(self.global_position, (Vector2(1, 0) * float($Body.flip_h) + Vector2(-1, 0) * float($Body.flip_h)),
					self.damage, self.pierce)
	get_tree().get_root().add_child(new_bullet)
	# $Weapon.play("default", ((fps of anim) * self.firerate) * (frames_of_anim))
	self.can_shoot = false
	$FirerateTimeout.start(1./self.firerate)
	
func _process(delta):
	var inputs = self.get_inputs()
	self.move(inputs, delta)
	self.shoot(inputs)
	if self.hp <= 0:
		self.queue_free()
		for entity in get_tree().get_nodes_in_group("Enemies"):
			entity.queue_free()
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_area_2d_area_entered(area):
	var enemy = area.get_parent()
	if enemy not in get_tree().get_nodes_in_group("Enemies"):
		return
	self.hp -= enemy.damage

func _on_firerate_timeout_timeout():
	self.can_shoot = true
