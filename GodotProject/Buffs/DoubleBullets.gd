extends Node

func _ready():
	get_parent().angular_bullets *= 2
	$Duration.connect("timeout", self, "Die")
	$Duration.start(9.8)
	pass # Replace with function body.

func Die():
	get_parent().angular_bullets /= 2
	queue_free()
