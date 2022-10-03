extends Node

const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_OUT

var fall_duration 
var cicle = 2
onready var target = get_parent()

func Start(fall_duration_l = 0.5):
	target.set_process(false)
	target.linear_velocity = target.linear_velocity * 0.2
	target.get_node("CollisionShape2D").set_deferred("disabled", true)
	$Duration.wait_time = fall_duration_l;
	$Duration.start()
	BecomeRed()


func BecomeRed():
	$Tween.interpolate_property(target,"modulate",target.modulate,Color(1,0,0,1),$Duration.wait_time,TRANS,EASE)
	$Tween.start()

func Vanish():
	$Tween.interpolate_property(target,"modulate",target.modulate,Color(1,0,0,0),$Duration.wait_time,TRANS,EASE)
	$Tween.start()

func _on_Duration_timeout():
	if(cicle == 2):
		$Tween.stop(target)
		Vanish()
		cicle -= 1
	else:
		
		target.hide()
		target.queue_free()
	
	
