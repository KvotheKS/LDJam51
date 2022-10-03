extends Timer

var speed_modifier = 1.35
onready var parnt = get_parent()

func _ready():
	parnt.speed *= speed_modifier
	connect("timeout", self, "Die")
	start(9.8)

func Die():
	parnt.speed /= speed_modifier
	queue_free()
