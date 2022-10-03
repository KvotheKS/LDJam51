extends Node

signal player_buffs(Player)
signal enemy_buffs(Enemy)

var bullshit_level = 0

var PlayerModifiers = [
		"FasterMotion", "SlowMotion", "FasterShooting", 
		"DoubleBullets", "RepeatingBullets", "TeleportedBullets", 
		"Armored",
		"HeavyBullets", "LaceratingBullets", "PoisonousBullets",
		"TrackingBullets", "PowderedBullets"
]

var EnemyModifiers = [
	"FasterMotion"
]

var StatusEffects = {
	"Lacerating" : 0,
	"Poisonous" : 0,
	"Powdered" : 0,
}

var ProtectionEffects = {
	"Armored" : 0,
	"SafeGuard": 0,
}

var monster_buff_scenes = {
	"FasterMotion": load("res://Buffs/FasterMotion.tscn"), 
}

var debuff_names = ["Powdered", "Lacerating", "Poisonous"]

var debuff_scenes = {
	"Powdered" : load("res://Buffs/PowderedEnemy.tscn"),
	"Lacerating" : load("res://Buffs/Bleeding.tscn"),
	"Poisonous" : load("res://Buffs/Poisoned.tscn"),
}

var enemy_explosion_scene = load("res://Scenes/explosion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

func ResetBuffs():
	bullshit_level += 1
	
	var dup_buffs = []
	
	for i in PlayerModifiers:
		dup_buffs.append(i)
	dup_buffs.shuffle()
	
	var player_buffs = []
	for i in bullshit_level:
		
		if i > dup_buffs.size():
			break
			
		player_buffs.append(dup_buffs[i])
	
	emit_signal("player_buffs", player_buffs)
	return
