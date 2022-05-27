extends Node

onready var sm = get_parent()
onready var kino = get_parent().get_parent()


func startState():
	sm.setAnimation("Walk")


func physics_process(_delta):
	if not kino.is_on_floor():
		sm.changeState("Falling")
	
	#if Input.is_action_pressed("Left") or Input.is_action_pressed("Right"):
	get_input()
	kino.velocity.y += sm.gravity * _delta
	kino.velocity = kino.move_and_slide(kino.velocity, Vector2.UP, true)
		
	
	if Input.is_action_just_pressed("Jump"):
		sm.changeState("Jump")
	
	if kino.velocity.x > 0 or kino.velocity.x == 0:
		if sm.dir == 0 and kino.velocity.x < 1:
			sm.changeState("Idle")
	elif kino.velocity.x < 0 or kino.velocity.x == 0:
		if sm.dir == 0 and kino.velocity.x >= -1:
			sm.changeState("Idle")



func get_input():
	sm.dir = 0
	
	if Input.is_action_pressed("Right") and not Input.is_action_pressed("Left"):
		sm.dir += 1
		kino.flip(false)

	if Input.is_action_pressed("Left") and not Input.is_action_pressed("Right"):
		sm.dir -= 1
		kino.flip(true)
	
	if sm.dir != 0:
		kino.velocity.x = lerp(kino.velocity.x, sm.dir * sm.speed, sm.acceleration)
	else:
		kino.velocity.x = lerp(kino.velocity.x, 0, sm.friction)
