extends Area2D

func _ready():
	connect("body_exited", self, "BodyExited")
	connect("body_entered", self, "BodyEntered")
	pass

func BodyExited(body: Node) -> void:
	#body.emit_signal("Falling")
	return

func BodyEntered(body: Node) -> void:
	if(body.is_in_group("ENEMY_G")):
		body.Die()
	return