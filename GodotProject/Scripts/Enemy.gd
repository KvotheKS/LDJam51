extends RigidBody2D

var speed = 100

var max_hp = 30
var hp = max_hp
var hp_regem = 0

var split = 0 #


var target 

var mod

func SetStatus():
	pass
	
func _ready():
	speed = rand_range(50,150)
	pass

func _process(delta):
	linear_velocity = (target.position - global_transform.origin).normalized() * speed 


func SetTarget(body):
	target = body

func TakeDamage(damage):
	
	hp -= damage
	if hp <= 0:
		hp = 0
		Die()
		
func Die():
	pass
	
