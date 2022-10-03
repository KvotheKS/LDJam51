extends Node

onready var LinearBody = get_parent()
var linear_speed = 0
var speed = Vector2.ZERO

func _ready():
	pass # Replace with function body.

func SetParameters(new_speed: float, new_angle: float) -> void:
	linear_speed = new_speed
	speed = Vector2(new_speed,0).rotated(new_angle)	
	return

func _physics_process(delta: float) -> void:
	LinearBody.position += speed * delta
	return
