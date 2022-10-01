extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_exited", self, "BodyExited")
	connect("body_entered", self, "BodyEntered")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func BodyExited(body: Node) -> void:
	body.emit_signal("Falling")
	return

func BodyEntered(body: Node) -> void:
	body.emit_signal("Entering")
	return
