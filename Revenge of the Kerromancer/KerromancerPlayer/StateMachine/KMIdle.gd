extends Node

onready var sm = get_parent()
onready var kino = get_parent().get_parent()


func startState():
	sm.setAnimation("Idle")


func physics_process(_delta):
	if not kino.is_on_floor():
		sm.changeState("Falling")
	
	if Input.is_action_pressed("Left") and Input.is_action_pressed("Right"):
		pass
	elif Input.is_action_pressed("Left") or Input.is_action_pressed("Right"):
		sm.changeState("Walk")
	
	if Input.is_action_just_pressed("Jump"):
		sm.changeState("Jump")
