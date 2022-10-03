extends Node

var speed_modifier = 1.5

func _ready():
	get_parent().time_between *= speed_modifier
	$Duration.connect("timeout", self, "Die")
	$Duration.start(10)
	pass # Replace with function body.

func Die():
	get_parent().time_between /= speed_modifier
	queue_free()
