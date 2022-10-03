extends Node

func _ready():
	var parnt = get_parent()
	parnt.add_to_group("Powdered")
	parnt.get_node("Sprite").modulate = Color(925103)
	queue_free()
