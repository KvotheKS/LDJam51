extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var parnt = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	parnt.get_node("Sprite").modulate = Color(0.2, 0.75, 0.2, 1)
	parnt.add_to_group("Poisonous")
	pass # Replace with function body.

func _process(delta):
	return
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
