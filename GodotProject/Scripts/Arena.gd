extends Area2D

func _ready():
	connect("body_exited", self, "BodyExited")
	pass

func BodyExited(body: Node) -> void:
	body.emit_signal("Falling")
	return

