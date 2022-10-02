extends KinematicBody2D

const MOVESPEED = 500
const BASEBULLETSPEED = 300 
const BASEBULLETMAX = 450
const BASEBULLETSIZE = Vector2(45,45)

var velocity = Vector2.ZERO

signal Falling()
signal Entering()

var base_bullet = load("res://Resources/projetil_normal1.png")
var bullet_scene = load("res://Scenes/Bullet.tscn")
var ondular_movement = load("res://Scenes/OndularMovement.tscn")
var linear_movement = load("res://Scenes/LinearMovement.tscn")

func _ready():
	connect("Falling", self, "OnFall")
	connect("Entering", self, "OnEnter")
	return

func _process(delta: float) -> void:
	PlayerInputs()
	move_and_slide(velocity.normalized() * MOVESPEED)
	return

func PlayerInputs():
	velocity.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	velocity.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	if Input.is_action_just_pressed("left_click"):
		Shoot()
	if(Input.is_action_pressed("w_key")):
		$Sprite/DamageTakenBehavior.Start()
	return

func Shoot():
	var bullet_angle = (get_global_mouse_position() - position).angle()
	var bullet_instance = bullet_scene.instance()
	
	var bullet_sprite = Sprite.new()
	bullet_sprite.texture = base_bullet
	
	bullet_sprite.rotation = bullet_angle + PI/2
	bullet_sprite.scale = BASEBULLETSIZE/bullet_sprite.get_rect().size
	
	var movement = linear_movement.instance()
	movement.SetParameters(BASEBULLETSPEED, bullet_angle)
	bullet_instance.SetParameters(position, bullet_sprite, movement, BASEBULLETMAX)

	get_parent().add_child(bullet_instance)
	return

func OnFall():	
	#$Sprite.modulate = Color(1, 0, 0, 1)
	return

func OnEnter():
	print("on enter hat")
	#$Sprite.modulate = Color.white
	return
