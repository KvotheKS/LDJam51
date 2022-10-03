extends Node2D

export(PackedScene) var enemy_scene

var quantity = 4
var beefyness = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	GenerateEnemies()
	$Duration.connect("timeout", self, "GenerateEnemies")
	$Audio/OST.play()

func GenerateEnemies():
	beefyness += 0.3
	quantity += 0.5
	for i in range(floor(quantity)):
		var enemy = enemy_scene.instance()
		enemy.beefy = beefyness
		enemy.SetTarget($Player)
		var distance = rand_range(0, $Arena/CollisionShape2D.shape.radius)
		var angle = rand_range(0,2*PI)
		enemy.global_position = $Arena.global_position + Vector2(distance, 0).rotated(angle)
		add_child(enemy)
	return
