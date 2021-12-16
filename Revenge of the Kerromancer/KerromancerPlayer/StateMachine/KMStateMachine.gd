extends Node

onready var parent = get_parent()
onready var sprite = parent.get_node("Graphic")
onready var debug = get_parent().get_node("Debug")

onready var state = null
onready var previousState = null
var stateName = ""

export (int) var speed = 400
export (int) var jump_speed = -650
export (int) var gravity = 1000

export (float, 0, 1.0) var friction = 0.292
export (float, 0, 1.0) var acceleration = 0.056

var momentum = 0
const MAX_MOMENTUM = 300

var dir = 0

func _ready():
	changeState("Idle")

func _physics_process(delta):
	if state.has_method("physics_process"):
		state.physics_process(delta)

func changeState(name):
	if state != null:
		previousState = state
	state = get_node(name)
	stateName = name
	debug.text = stateName
	
	if previousState != null:
		if previousState.has_method("endState"):
			previousState.endState()
	
	if state.has_method("startState"):
		state.startState()

func setAnimation(anim):
	if sprite.animation != anim:
		if sprite.frames.has_animation(anim):
			sprite.play(anim)
		else:
			sprite.play()



