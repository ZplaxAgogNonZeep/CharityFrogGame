extends Node

onready var sm = get_parent()
onready var kino = get_parent().get_parent()

func _ready():
	set_physics_process(false)

func startState():
	set_physics_process(true)
	sm.setAnimation("Idle")

func stateEnd():
	set_physics_process(false)

func _physics_process(_delta):
	
	if not kino.is_on_floor():
		sm.changeState("Falling")
	
	if Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right"):
		sm.changeState("Walk")
	
	if Input.is_action_just_pressed("Jump"):
		sm.changeState("Jump")
