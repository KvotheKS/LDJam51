extends Node

func _ready():
	$Duration.connect("timeout", self, "ShootAgain")
	$Duration.start(get_parent().time_between/3)
	pass # Replace with function body.

func ShootAgain():
	var parnt = get_parent()
	parnt.ShootType.call_func(parnt.last_info)
	queue_free()
