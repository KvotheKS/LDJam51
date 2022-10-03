extends Timer

onready var parnt = get_parent()
var ticks = 7

func _ready():
	connect("timeout", self, "BleedTick")

func BleedTick():
	if ticks == 0 or parnt.hp <= 0:
		queue_free()
		return
	ticks -= 1
	parnt.TakeDamage(parnt.max_hp*0.06)
