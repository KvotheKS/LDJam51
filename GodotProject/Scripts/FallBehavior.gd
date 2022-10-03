extends Node

const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_IN

var fall_duration 
var sparkle_duration
var cicle = 2
onready var target = get_parent()

func Start(fall_duration_l = 1):
	
	if(target.position.y < get_viewport().size.y/2):
		target.z_index = -10
	$Duration.wait_time = fall_duration_l;
	$Duration.start()
	NewFall()


func NewFall():
	
	$Tween.interpolate_property(target,"scale",target.scale,Vector2(0,0),$Duration.wait_time,TRANS,EASE)
	$Tween.start()
	
func _on_Duration_timeout():
	#!!add intanciation of spark or something idk
	target.hide()
	target.queue_free()
	
	
	
