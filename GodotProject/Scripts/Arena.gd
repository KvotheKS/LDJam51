extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "BodyExited")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func BodyExited(body):
	if(body.name == "Player"):
		#emit_signal("body_exited", )
		return
