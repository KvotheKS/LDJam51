extends AnimatedSprite

func _ready():
	$Area2D.damage = 8000
	$Area2D/CollisionShape2D.shape.extents = Vector2(15,15)
	$Duration.connect("timeout", self, "Die")

func Die():
	queue_free()
