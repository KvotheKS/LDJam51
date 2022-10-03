extends KinematicBody2D

const MOVESPEED = 500
const BASEBULLETSPEED = 300 
const BASEBULLETMAX = 450
const BASEBULLETSIZE = Vector2(45,45)

var velocity = Vector2.ZERO

signal Falling()
signal Entering()
signal Shoot()

var base_bullet = load("res://Resources/projetil_normal1.png")
var bullet_scene = load("res://Scenes/Bullet.tscn")
var ondular_movement = load("res://Scenes/OndularMovement.tscn")
var linear_movement = load("res://Scenes/LinearMovement.tscn")
#Hit enum
enum {SLASH = 1, PEW = 2, FAIL = 3, FIRE = 4}
var curr_hit_sound = SLASH

func _ready():
	$Area2D.connect("area_entered", self, "OnEnemy")
	connect("Falling", self, "OnFall")
	connect("Entering", self, "OnEnter")
	$Gun.SetOwner(self, "BaseBulletSprite", "BaseBulletInfo")
	$Gun.SetShootingType("TripleSimpleShoot")
	$Gun.SetTimeBetween(0.5)
	return

func _process(delta: float) -> void:
	PlayerInputs()
	move_and_slide(velocity.normalized() * MOVESPEED)
	
	return

func PlayerInputs():
	velocity.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	velocity.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	if Input.is_action_pressed("left_click"):
		#Shoot()
		$Gun.emit_signal("Shoot", [position, (get_global_mouse_position() - position).angle()])


	#When associating the sound with an action, 
	#use the set enum and the function 
	#LoadSound(enum) for changing the hit sound
	#example below:
	if Input.is_action_just_pressed("down"):
		LoadHitSound(FAIL)
		$Hit.play()
	elif Input.is_action_just_pressed("left"):
		LoadHitSound(SLASH)
		$Hit.play()
	elif Input.is_action_just_pressed("right"):
		LoadHitSound(FIRE)
		$Hit.play()
	elif Input.is_action_just_pressed("up"):
		LoadHitSound(PEW)
		$Hit.play()
	return

func BaseBulletInfo():
	return [BASEBULLETSPEED, BASEBULLETMAX]

func BaseBulletSprite():
	var bullet_sprite = Sprite.new()
	bullet_sprite.texture = base_bullet
	bullet_sprite.scale = BASEBULLETSIZE/bullet_sprite.get_rect().size
	return bullet_sprite

func Shoot():
	var bullet_angle = (get_global_mouse_position() - position).angle()
	var bullet_instance = bullet_scene.instance()
	
	var bullet_sprite = Sprite.new()
	bullet_sprite.texture = base_bullet
	bullet_sprite.scale = BASEBULLETSIZE/bullet_sprite.get_rect().size
	bullet_sprite.rotation = bullet_angle + PI/2
	
	var movement = linear_movement.instance()
	movement.SetParameters(BASEBULLETSPEED, bullet_angle)
	bullet_instance.SetParameters(position, bullet_sprite, movement, BASEBULLETMAX)

	get_parent().add_child(bullet_instance)
	return

func OnEnemy(area):
	if area.is_in_group("ENEMY_G"):
		$DamageTakenBehavior.Start()

func OnFall():	
	#$Sprite.modulate = Color(1, 0, 0, 1)
	return

func OnEnter():
	print("on enter hat")
	#$Sprite.modulate = Color.white
	return


#Move to external file
func LoadHitSound(to_load: int):

	if to_load != curr_hit_sound and to_load == FAIL:
		curr_hit_sound = to_load
		$Hit.stream = preload("res://Audio/wah.ogg")

	elif to_load != curr_hit_sound and to_load == SLASH:
		curr_hit_sound = to_load
		$Hit.stream = preload("res://Audio/posh.ogg")

	elif to_load != curr_hit_sound and to_load == FIRE:
		curr_hit_sound = to_load
		$Hit.stream = preload("res://Audio/woh.ogg")

	elif to_load != curr_hit_sound and to_load == PEW:
		curr_hit_sound = to_load
		$Hit.stream = preload("res://Audio/pwew.ogg")
