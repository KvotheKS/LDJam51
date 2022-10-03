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
	queue_free()
	

func _on_Enemy_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print("ouchmama") #n interage com areas 2d


func _on_Area2D_area_entered(area):
	if area.is_in_group("BULLET_G"):
		TakeDamage(15)
