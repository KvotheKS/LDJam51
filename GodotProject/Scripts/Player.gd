extends KinematicBody2D


func _ready():
	pass # Replace with function body.

const MOVESPEED = 500

var velocity = Vector2.ZERO
onready var r_cast = $Raycast

func _process(delta: float) -> void:
	ArenaCollision()
	PlayerInputs()
	
	move_and_slide(velocity.normalized() * MOVESPEED)
	return

func PlayerInputs():
	velocity.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	velocity.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))

func ArenaCollision():
	
	return
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
