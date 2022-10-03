extends Node

signal player_buffs(Player)
signal enemy_buffs(Enemy)

var bullshit_level = 0

var PlayerModifiers = {
	"Basic" : [
		"FasterMotion", "SlowMotion", "FasterShooting", 
		"DoubleBullets", "RepeatingBullets", "TeleportedBullets", 
		"Armored"
	],
	"Complex" : [
		"HeavyBullets", "LaceratingBullets", "PoisonousBullets",
		"SafeGuard"
	],
	"Supreme" : [
		"TrackingBullets", "ExplodeEnemy"
	],
}

var EnemyModifiers = {
	"Basic" : ["FasterMotion", "SlowMotion"],
	"Complex" : ["Exploding", "StrongPushback"],
	"Supreme" : ["Hydra"]
}

var StatusEffects = {
	"Lacerating" : 0,
	"Poisonous" : 0,
}

var ProtectionEffects = {
	"Armored" : 0,
	"SafeGuard": 0,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	$Duration.connect("timeout", self, "ResetBuffs")

func ResetBuffs():
	var player_buffs = ["DoubleBullets"]
	var enemy_buffs = []
	
	emit_signal("player_buffs", player_buffs)
	emit_signal("enemy_buffs", enemy_buffs)
	
	bullshit_level += 1
	
	return
