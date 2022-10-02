extends KinematicBody2D

const MOVESPEED = 500

var velocity = Vector2.ZERO

#Hit enum
enum {SLASH = 1, PEW = 2, FAIL = 3, FIRE = 4}
var curr_hit_sound = SLASH

signal Falling
signal Entering

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

func OnFall():	
	$Sprite.modulate = Color(1, 0, 0, 1)
	return

func OnEnter():
	$Sprite.modulate = Color.white
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
