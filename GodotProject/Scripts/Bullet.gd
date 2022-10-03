extends Area2D

func _ready():
	pass

var curr_distance = 0
var max_distance = 15000
var damage

func SetParameters(central_position: Vector2, sprite, movement_type, new_distance: float, new_damage:float ) -> void:
	var rect_info = sprite.get_rect()
	$CollisionShape2D.shape.extents = rect_info.size
	sprite.name = "Sprite"
	position = central_position
	add_child(sprite)

	movement_type.name = "Movement"
	add_child(movement_type)
	
	max_distance = new_distance
	damage = new_damage
	
	return

func _process(delta: float) -> void:
	curr_distance += $Movement.speed * delta
	if(max_distance <= curr_distance):
		hide()
		queue_free()	
	return
