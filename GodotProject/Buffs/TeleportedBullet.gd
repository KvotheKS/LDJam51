extends Node

var speed_modifier = 1.75

func _ready():
	var parnt = get_parent()
	var movement = parnt.get_node("Movement")
	parnt.max_distance += get_viewport().size.length()
	var old_position = parnt.global_position
	parnt.position += get_viewport().size.rotated(movement.angle)
	movement.angle = (old_position - parnt.global_position).angle()
	movement.speed *= speed_modifier
	queue_free()
	pass # Replace with function body.
