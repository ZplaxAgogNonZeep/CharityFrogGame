extends Node

onready var sm = get_parent()
onready var kino = get_parent().get_parent()

func startState():
	print(kino.position)
	kino.position = kino.position + Vector2(0, -5)
	print(kino.position)
	sm.momentum = 0
	kino.velocity.x = 0
	kino.velocity.y = -300
	kino.vulnerable = false
	$Timer.start(1)
	sm.setAnimation("Falling")

func physics_process(_delta):
	get_input()
	
	kino.velocity.y += sm.gravity * _delta
	kino.velocity = kino.move_and_slide(kino.velocity, Vector2.UP)
	
	if kino.is_on_floor() and kino.velocity.y > -300:
		#kino.velocity.x = 0
		sm.changeState("Walk")

func get_input():
	sm.dir = 0
	
	if kino.sprite.flip_h:
		sm.dir = 1
	else:
		sm.dir = -1
	
	kino.velocity.x = lerp(kino.velocity.x, sm.dir * sm.speed, sm.acceleration)



