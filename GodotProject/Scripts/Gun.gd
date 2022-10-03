extends Node

var time_between = 0
var bullet_scene = load("res://Scenes/Bullet.tscn")
var linear_movement = load("res://Scenes/LinearMovement.tscn")
var can_shoot = true

signal Shoot(info)
var GenerateBulletSprite = null
var GenerateBulletInfo = null

func _ready():
	$Duration.connect("timeout", $Duration, "stop")

func SetGenSprite(parnt, gen_bullet_spr):
	GenerateBulletSprite = funcref(parnt, gen_bullet_spr)

func SetGenBullet(parnt, gen_bullet_info):
	GenerateBulletInfo = funcref(parnt, gen_bullet_info)

func SetTimeBetween(new_time):
	time_between = new_time

func SetShootingType(shoot_type):
	connect("Shoot", self, shoot_type)

func SetOwner(parnt, gen_bullet_spr, gen_bullet_info):
	SetGenSprite(parnt, gen_bullet_spr)
	SetGenBullet(parnt, gen_bullet_info)
# recebe [central_position, angle]
func ManageShoot():
	if !$Duration.is_stopped():
		return false
	$Duration.start(time_between)
	return true

func SimpleShootBase(info):
	if ManageShoot():
		SimpleShoot(info)
	
func SimpleShoot(info):
	var bullet_angle = info[1]
	var bullet_instance = bullet_scene.instance()
	var bullet_sprite = GenerateBulletSprite.call_func()
	#[speed, max_distance]
	var bullet_info = GenerateBulletInfo.call_func()
	bullet_sprite.rotation = bullet_angle
	
	var movement = linear_movement.instance()
	movement.SetParameters(bullet_info[0], bullet_angle)
	bullet_instance.SetParameters(info[0], bullet_sprite, movement, bullet_info[1])
	add_child(bullet_instance)

# recebe [central_position, central_angle]
func TripleSimpleShoot(info):
	if ManageShoot():
		SimpleShoot(info)
		info[1] += PI/6
		SimpleShoot(info)
		info[1] -= PI/3
		SimpleShoot(info)
	return
