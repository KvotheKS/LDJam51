extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var curr_distance = 0
var max_distance = 15000

func SetParameters(central_position: Vector2, sprite: Sprite, movement_type, new_distance: float) -> void:
	var rect_info = sprite.get_rect()
	$CollisionShape2D.shape.extents = rect_info.size
	sprite.name = "Sprite"
	position = central_position
	add_child(sprite)

	movement_type.name = "Movement"
	add_child(movement_type)
	
	max_distance = new_distance
	
	return

func _process(delta: float) -> void:
	curr_distance += $Movement.linear_speed * delta
	if(max_distance <= curr_distance):
		hide()
		queue_free()	
	return
