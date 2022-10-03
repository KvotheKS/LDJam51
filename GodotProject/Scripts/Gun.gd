extends Node2D

var time_between = 0
var bullet_scene = load("res://Scenes/Bullet.tscn")
var linear_movement = load("res://Scenes/LinearMovement.tscn")

var gun_buff_scenes = {
	"FasterShooting": load("res://Buffs/FastShooting.tscn"),
	"RepeatingBullets": load("res://Buffs/RepeatingBullets.tscn"),
	"DoubleBullets": load("res://Buffs/DoubleBullets.tscn"),
	"AddBullet": load("res://Buffs/AddBullet.tscn"),
}

var on_shoot_buffs = {"RepeatingBullets": 0}

var current_gun_buffs = []

var bullet_buff_scenes = {
	"LaceratingBullets" : load("res://Buffs/Lacerating.tscn"),
	"PoisonousBullets" : load("res://Buffs/Poisonous.tscn"),
	"HeavyBullets" : load("res://Buffs/BigSlow.tscn"),
	"TeleportedBullets" : load("res://Buffs/TeleportedBullet.tscn"),
	"TrackingBullets": load("res://Scenes/TrackingMovement.tscn"),
}

var current_bullet_buffs = []

var last_info = []
var angular_bullets = 1
var speed = 1
# triplo, repetida e simples? repetida -> tripla
# repeticoes -> quantidade/multiplicadores -> tiro normal
var GenerateBulletSprite = null
var GenerateBulletInfo = null
var ShootType = funcref(self, "Cone")
onready var world = get_parent().get_parent()

func _ready():
	$Duration.connect("timeout", $Duration, "stop")

func SetGenSprite(parnt, gen_bullet_spr):
	GenerateBulletSprite = funcref(parnt, gen_bullet_spr)

func SetGenBullet(parnt, gen_bullet_info):
	GenerateBulletInfo = funcref(parnt, gen_bullet_info)

func SetShootType(Type):
	ShootType = funcref(self, Type)

func SetTimeBetween(new_time):
	time_between = new_time

func SetSimultaneousBullets(bullet_number):
	angular_bullets = bullet_number

func SetOwner(parnt, gen_bullet_spr, gen_bullet_info):
	SetGenSprite(parnt, gen_bullet_spr)
	SetGenBullet(parnt, gen_bullet_info)

# recebe [central_position, angle]
func ManageShoot():
	if !$Duration.is_stopped():
		return false
	$Duration.start(time_between)
	return true

func Shoot(info):
	if ManageShoot():
		last_info = info
		ShootType.call_func(info)
		for gun_buff in current_gun_buffs:
			add_child(gun_buff_scenes[gun_buff].instance())
	
func Around(info):
	var distance_between = 2*PI/angular_bullets
	var initial_angle = info[0]
	for i in angular_bullets:
		info[0] += distance_between
		SimpleShoot(info)
	info[0] = initial_angle

func Cone(info):
	var distance_between = (PI/2)/(angular_bullets+1)
	var initial_angle = info[0]
	info[0] -= PI/4
	for i in angular_bullets:
		info[0] += distance_between
		SimpleShoot(info)
	info[0] = initial_angle

func SimpleShoot(info):
	var bullet_angle = info[0]
	var bullet_instance = bullet_scene.instance()
	var bullet_sprite = GenerateBulletSprite.call_func()
	var bullet_info = GenerateBulletInfo.call_func()
	bullet_sprite.rotation = bullet_angle
	var movement = linear_movement.instance()
	movement.SetParameters(bullet_info[0], bullet_angle)
	bullet_instance.SetParameters(global_position, bullet_sprite, movement, bullet_info[1], bullet_info[2])
	
	for buff_type in current_bullet_buffs:
		bullet_instance.add_child(bullet_buff_scenes[buff_type].instance())
	world.add_child(bullet_instance)


func ResetBuffs(Player):
	current_bullet_buffs.clear()
	current_gun_buffs.clear()
	angular_bullets += 1
	for buff in Player:
		if bullet_buff_scenes.has(buff):
			current_bullet_buffs.append(buff)
		elif gun_buff_scenes.has(buff):
			if on_shoot_buffs.has(buff):
				current_gun_buffs.append(buff)
			else:
				add_child(gun_buff_scenes[buff].instance())
	return
