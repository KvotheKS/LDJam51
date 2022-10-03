extends Timer

onready var parnt = get_parent()

func _ready():
	connect("timeout", self, "Cease")
	parnt.connect("TakeDamage", self, "ArmoredTakeDamage")

func Cease():
	queue_free()

func ArmoredTakeDamage():
	parnt.get_node("Hit").play()
	parnt.disconnect("TakeDamage", self, "ArmoredTakeDamage")
	parnt.connect("TakeDamage", parnt, "NormalTakeDamage")
	queue_free()
