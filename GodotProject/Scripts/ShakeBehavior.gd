extends Node

const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT
# Declare member variables here. Examples:
var amplitude = 0
var priority = 0
var fade_shake = false;
onready var shaked_object = get_parent()

func Start(frequency = 0.05, amplitude = 10, duration = 0.25, priority = 0,fade_shake = true):
	if(self.priority <= priority):
		self.priority = priority
		self.amplitude = amplitude
		self.fade_shake = fade_shake
		
		
		$Frequency.wait_time = frequency
		$Frequency.start()

		$Duration.wait_time = duration
		$Duration.start()
		
		NewShake()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func NewShake():
	var rand = Vector2()
	rand.x = rand_range(-amplitude,amplitude)
	rand.y = rand_range(-amplitude,amplitude)
	
	$ShakeTween.interpolate_property(shaked_object, "offset",shaked_object.offset,rand,$Frequency.wait_time,TRANS,EASE)
	$ShakeTween.start()
	if(fade_shake):
		amplitude = amplitude*0.9
	
	

func Reset():
	$ShakeTween.interpolate_property(shaked_object,"offset",shaked_object.offset,Vector2(),$Frequency.wait_time,TRANS,EASE)
	$ShakeTween.start()


func _on_Frequency_timeout():
	NewShake()
	

func _on_Duration_timeout():
	Reset()
	$Frequency.stop()
