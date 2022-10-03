extends RigidBody2D


var speed = 1

var max_hp = 30
var hp = max_hp
var hp_regen = 0

var split = 0 #

var target 

var mod
var beefy = 1

signal TakeBullet(bullet)
signal Dead()

onready var buff_node = get_parent().get_node("Buffs")

func SetStatus():
	pass
	
func _ready():
	speed *= rand_range(50,150)
	max_hp = rand_range(0.75,1.5) * beefy * 30
	hp = max_hp
	$DeathBehavior/Hit.stream = preload("res://Audio/wah.ogg")
	connect("TakeBullet", self, "OnHealth")

func _process(delta):
	linear_velocity = (target.position - global_transform.origin).normalized() * speed 


func SetTarget(body):
	target = body

func TakeDamage(damage):
	hp -= damage
	$AnimatedSprite/ShakeBehavior.Start()
	if hp > 0:
		return
	hp = 0
	Die()

func _on_Area2D_area_entered(area):
	if area.is_in_group("BULLET_G"):
		emit_signal("TakeBullet", area)

func OnHealth(bullet):
	for debuff in buff_node.debuff_names:
		if bullet.is_in_group(debuff):
			add_child(buff_node.debuff_scenes[debuff].instance())
	TakeDamage(bullet.damage)

func Fall():
	$FallBehavior.Start()
	
func Die():
	$DeathBehavior.Start()
