extends Node

var state = null
var stateName

var previousState = null

onready var parent = get_parent()
onready var debug = get_parent().get_node("Label")
onready var sprite = parent.get_node("Graphic")

export (int) var speed = 400
export (int) var jump_speed = -650
export (int) var gravity = 1000

var dir = -1
var midAir
var onWall = false
var courseCorrect = false

func _ready():
	changeState("Idle")

func _physics_process(delta):
	if state.has_method("physics_process"):
		state.physics_process(delta)

func flipSprite():
	parent.scale.x *= -1
	dir *= -1

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
