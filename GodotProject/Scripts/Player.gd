extends KinematicBody2D

const MOVESPEED = 200
const BASEBULLETSPEED = 300 
const BASEBULLETMAX = 450
const BASEBULLETSIZE = Vector2(45,45)
const BASEBULLETDAMAGE = 30

const PLAYERMAXHEALTH = 8

var speed = 0
var velocity = Vector2.ZERO
var hp = PLAYERMAXHEALTH

signal Falling()
signal Entering()
signal Shoot()
signal TakeDamage()

var base_bullet = load("res://Resources/projetil_normal1.png")

var buff_scenes = {
	"FasterMotion" : load("res://Buffs/FasterMotion.tscn"), 
	"SlowMotion" : load("res://Buffs/SlowMotion.tscn"), 
	"Armored" : load("res://Buffs/Armored.tscn"), 
}

enum {SLASH = 1, PEW = 2, FAIL = 3, FIRE = 4}
var curr_hit_sound = SLASH

func _ready():
	var buff_timer = get_parent().get_node("Buffs")
	speed = MOVESPEED
	buff_timer.connect("player_buffs", $Gun, "ResetBuffs")
	buff_timer.connect("player_buffs", self, "ResetBuffs")
	$Area2D.connect("area_entered", self, "OnEnemy")
	connect("Falling", self, "OnFall")
	connect("Entering", self, "OnEnter")
	connect("TakeDamage", self, "NormalTakeDamage")
	$Gun.SetOwner(self, "BaseBulletSprite", "BaseBulletInfo")
	$Gun.SetSimultaneousBullets(1)
	$Gun.SetTimeBetween(0.5)
	$Hit.stream = preload("res://Audio/woh.ogg")
	return

func _process(delta: float) -> void:
	PlayerInputs()
	velocity = velocity.normalized() * speed
	move_and_slide(velocity)
	velocity *= delta
	return

func PlayerInputs():
	velocity.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	velocity.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	if Input.is_action_pressed("left_click"):
		#Shoot()
		$Gun.Shoot([(get_global_mouse_position() - position).angle()])
	
	return

func BaseBulletInfo():
	return [BASEBULLETSPEED, BASEBULLETDAMAGE]

func BaseBulletSprite():
	var bullet_sprite = Sprite.new()
	bullet_sprite.texture = base_bullet
	bullet_sprite.scale = BASEBULLETSIZE/bullet_sprite.get_rect().size
	return bullet_sprite

func NormalTakeDamage():
	hp -= 1
	if hp == 0:
		print("OUCHIE")

func OnEnemy(area):
	if area.is_in_group("ENEMY_G"):
		$DamageTakenBehavior.Start()
		$Hit.play()
		NormalTakeDamage()

func OnFall():	
	#$Sprite.modulate = Color(1, 0, 0, 1)
	return

func OnEnter():
	#$Sprite.modulate = Color.white
	return

func ResetBuffs(player_buffs):
	for buffs in player_buffs:
		if buff_scenes.has(buffs):
			add_child(buff_scenes[buffs].instance())
	return
