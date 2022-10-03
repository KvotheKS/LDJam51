extends Node

onready var LinearBody = get_parent()
var angle = 0
var speed = 0
var target = null
var time = 0

func _ready():
	var current_movement = LinearBody.get_node("Movement")
	angle = current_movement.angle
	speed = current_movement.speed
	LinearBody.call_deferred("removechild",current_movement)
	
	name = "Movement"
	target = ClosestEnemy()
	time = 0.3
	return

func ClosestEnemy():
	var world = LinearBody.get_parent()
	var bestguess = 10000000
	target = null
	for enemies in world.get_children():
		if enemies.is_in_group("ENEMY_G"):
			var dst = (LinearBody.global_position - enemies.global_position).length()
			if bestguess > dst:
				bestguess = dst
				target = enemies

func GetPlayer():
	var world = LinearBody.get_parent()
	for bodies in world.get_children():
		if bodies.is_in_group("Player"):
			target = bodies
			return

func SetParameters(new_speed: float, new_angle: float) -> void:
	angle = new_angle
	speed = new_speed
	return

func _physics_process(delta: float) -> void:
	time -= delta
	if time > 0:
		LinearBody.position += Vector2(speed,0).rotated(angle) * delta
		return
	if not is_instance_valid(target):
		ClosestEnemy()
		if target == null:
			GetPlayer()
	var interpol_intensity = (speed * delta)/((LinearBody.global_position-target.global_position).length()+0.001)
	LinearBody.global_position = LinearBody.global_position.linear_interpolate(target.global_position, min(1,interpol_intensity))
	return
