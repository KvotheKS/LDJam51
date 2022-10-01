extends Node

onready var parent = get_parent()

func _process(delta):
	parent.z_index = parent.position.y
