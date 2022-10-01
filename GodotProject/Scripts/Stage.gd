extends Node2D

export(PackedScene) var enemy_scene


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(10):
		var enemy =  enemy_scene.instance()
		
		enemy.SetTarget($Player)
		
		add_child(enemy)


#func _process(delta):
#	pass
