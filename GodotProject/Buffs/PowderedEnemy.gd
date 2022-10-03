extends Timer

onready var parnt = get_parent()

func _ready():
	parnt.get_node("DeathBehavior").get_node("Duration").connect("timeout", self, "SpawnExplosion")
	
func SpawnExplosion():
	print("WWWOOOOOWWW")
