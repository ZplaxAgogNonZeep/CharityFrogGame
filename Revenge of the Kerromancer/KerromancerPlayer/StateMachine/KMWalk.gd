extends Node

onready var sm = get_parent()
onready var kino = sm.parent

func _ready():
	set_physics_process(false)

func stateStart():
	set_physics_process(true)
	sm.setAnimation("Walk")

func stateEnd():
	set_physics_process(false)

func _physics_process(_delta):
	
	if not sm.parent.is_on_floor():
		sm.changeState("Falling")
	
	if Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right"):
		get_input()
		kino.velocity.y += sm.gravity * _delta
		kino.parent.velocity = kino.move_and_slide(kino.velocity, Vector2.UP)
		
	elif Input.is_action_just_pressed("Jump"):
		sm.changeState("Jump")
	else:
		sm.changeState("Idle")

func get_input():
	sm.dir = 0
	
	if Input.is_action_pressed("Right"):
		sm.dir += 1
		sm.sprite.flip_h = false

	if Input.is_action_pressed("Left"):
		sm.dir -= 1
		sm.sprite.flip_h = true
		
	if sm.dir != 0:
		kino.velocity.x = lerp(kino.velocity.x, sm.dir * sm.speed, sm.acceleration)
	else:
		# 
		kino.velocity.x = lerp(kino.velocity.x, 0, sm.friction)
