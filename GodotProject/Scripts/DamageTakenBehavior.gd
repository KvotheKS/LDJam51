extends Node

const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT
# Declare member variables here. Examples:

var priority = 0

onready var affected_node = get_parent()

func Start(duration = 1, priority = 0):
	if(self.priority <= priority):
		self.priority = priority


		$Duration.wait_time = duration
		$Duration.start()
		
		NewShake()


func _ready():
	pass 

func NewShake():
	$AlphaTween.interpolate_property(affected_node,"modulate",Color(1,1,1,0.6),Color(1,1,1,0.8),$Duration.wait_time,TRANS,EASE)
	$AlphaTween.start()



func _on_Duration_timeout():
	$AlphaTween.stop(affected_node)
	affected_node.modulate = Color(1,1,1,1)
	$Duration.stop()
