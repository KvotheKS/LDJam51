extends Timer

func _ready():
	connect("timeout", self, "Die")
	start(0.2)

func Die():
	get_parent().angular_bullets += 1
	queue_free()
