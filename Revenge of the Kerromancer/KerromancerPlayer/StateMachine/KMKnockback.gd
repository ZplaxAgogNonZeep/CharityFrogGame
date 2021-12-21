extends Node

onready var sm = get_parent()
onready var kino = get_parent().get_parent()

func startState():
	sm.momentum = 0
	kino.velocity.x = 0
	kino.velocity.y = -300
	kino.vulnerable = false
	$Timer.start(1)

func endState():
	kino.vulnerable = true

func physics_process(_delta):
	get_input()
	
	kino.velocity.y += sm.gravity * _delta
	kino.velocity = kino.move_and_slide(kino.velocity, Vector2.UP)
	
	if kino.visible:
		kino.visible = false
	else:
		kino.visible = true
	
	if kino.is_on_floor() and kino.velocity.y > -300:
		#kino.velocity.x = 0
		kino.visible = true
		sm.changeState("Walk")

func get_input():
	sm.dir = 0
	
	if kino.sprite.flip_h:
		sm.dir = 1
	else:
		sm.dir = -1
	
	kino.velocity.x = lerp(kino.velocity.x, sm.dir * sm.speed, sm.acceleration)


func _on_Timer_timeout():
	if !kino.vulnerable:
		kino.visible = true
		sm.changeState("Idle")