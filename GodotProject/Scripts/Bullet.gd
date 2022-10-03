extends Area2D

var damage

func _ready():
	$Duration.connect("timeout", self, "Die")
	$Duration.start(3)
	connect("area_entered", self, "BodyEntered")

func SetParameters(central_position: Vector2, sprite, movement_type, new_damage:float) -> void:
	var rect_info = sprite.get_rect()
	$CollisionShape2D.shape.extents = rect_info.size
	sprite.name = "Sprite"
	position = central_position
	add_child(sprite)

	movement_type.name = "Movement"
	add_child(movement_type)
	
	damage = new_damage
	
	return

func Die():
	queue_free()

func BodyEntered(area):
	if area.is_in_group("ENEMY_G"):
		queue_free()
