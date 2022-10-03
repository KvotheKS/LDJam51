extends Node

onready var OndularBody = get_parent()
var linear_speed = 0
var period = 0
var amplitude = 0
var angle = 0
var current_distance = 0

func _ready():
	pass # Replace with function body.
# 6.28 pixels eh uma "Rotacao" inteira. period serve para vc modificar isso. se period for 0.5, 
# o resultado eh essencialmente sin(x*0.5)
func SetParameters(new_speed: float, new_angle: float, new_amplitude: float, new_period: float) -> void:
	linear_speed = new_speed
	angle = new_angle
	amplitude = new_amplitude
	period = new_period
	return

func _physics_process(delta: float) -> void:
	current_distance += linear_speed * delta
	
	var full_rotations = floor(current_distance*period/(2*PI))
	var current_angle = current_distance - full_rotations*2*PI / period
	var mins = 1
	if current_angle*period >= PI/2 and current_angle*period <= PI*3/2:
		mins = -1
	OndularBody.position += Vector2(linear_speed * delta, mins*sin(linear_speed * delta)*amplitude).rotated(angle)
	return
