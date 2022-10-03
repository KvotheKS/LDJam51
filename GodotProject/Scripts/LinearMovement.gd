extends Node

onready var LinearBody = get_parent()
var angle = 0
var speed = 0

func _ready():
	pass # Replace with function body.

func SetParameters(new_speed: float, new_angle: float) -> void:
	angle = new_angle
	speed = new_speed	
	return

func _physics_process(delta: float) -> void:
	LinearBody.position += Vector2(speed,0).rotated(angle) * delta
	return
