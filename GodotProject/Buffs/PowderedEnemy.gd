extends Timer

onready var parnt = get_parent()

func _ready():
	parnt.get_node("DeathBehavior").get_node("Duration").connect("timeout", self, "SpawnExplosion")
	
func SpawnExplosion():
	var xpl = parnt.get_parent().get_node("Buffs").enemy_explosion_scene.instance()
	xpl.global_position = parnt.global_position
	parnt.get_parent().add_child(xpl)
