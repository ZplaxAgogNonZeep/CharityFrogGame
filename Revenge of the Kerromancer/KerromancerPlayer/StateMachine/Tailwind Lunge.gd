extends Node

onready var sm = get_parent()
onready var kino = get_parent().get_parent()

export var speed := 800.0
export var MAX_Distance := 200.0

func startState():
	sm.setAnimation("Jump")
	
	if kino.get_node("Graphic").flip_h:
		kino.velocity = Vector2(-speed, 0)
	else:
		kino.velocity = Vector2(speed, 0)
	
	$Timer.start(MAX_Distance/speed)


func endState():
	if kino.get_node("Graphic").flip_h:
		kino.velocity.x = sm.speed * -1
	else:
		kino.velocity.x = sm.speed

func physics_process(_delta):

	kino.velocity = kino.move_and_slide(kino.velocity, Vector2.UP)



func _on_Timer_timeout():
	sm.changeState("Falling")
