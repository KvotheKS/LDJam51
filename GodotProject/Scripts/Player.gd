extends KinematicBody2D

const MOVESPEED = 500

var velocity = Vector2.ZERO

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
	
	if(Input.is_action_pressed("w_key")):
		$Sprite/DamageTakenBehavior.Start()
	return

func OnFall():	
	#$Sprite.modulate = Color(1, 0, 0, 1)
	return

func OnEnter():
	#$Sprite.modulate = Color.white
	return
