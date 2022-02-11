extends KinematicBody2D


onready var start = $Start.global_position
onready var end = $End.global_position

export var speed : float

var velocity : Vector2 = Vector2.ZERO
var dir : int  = 0
var forward


func _ready():
	forward = true
	$Tween.interpolate_property(self, "position", start, end, speed, Tween.TRANS_SINE)
	$Tween.start()


func _on_Tween_tween_all_completed():
	forward = !forward
	if forward:
		$Tween.interpolate_property(self, "position", start, end, speed, Tween.TRANS_SINE)
	else:
		$Tween.interpolate_property(self, "position", end, start, speed, Tween.TRANS_SINE)
	$Tween.start()
