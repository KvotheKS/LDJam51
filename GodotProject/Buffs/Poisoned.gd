extends Timer

onready var parnt = get_parent()
var ticks = 5
var speed_modifier = 1.3

func _ready():
	parnt.speed /= speed_modifier
	connect("timeout", self, "PoisonTick")

func PoisonTick():
	if ticks == 0 or parnt.hp <= 0:
		parnt.speed *= speed_modifier
		queue_free()
		return
	ticks -= 1
	parnt.TakeDamage(parnt.max_hp*0.05)
