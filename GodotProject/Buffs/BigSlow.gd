extends Node

var size_modifier = 1.5
var speed_modifier = 0.75

func _ready():
	var parnt = get_parent()
	var sprite = parnt.get_node("Sprite")
	var collision = parnt.get_node("CollisionShape2D")
	var movement = parnt.get_node("Movement")
	parnt.damage *= size_modifier
	sprite.scale *= size_modifier
	collision.shape.extents *= size_modifier
	movement.speed *= speed_modifier
	queue_free()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
