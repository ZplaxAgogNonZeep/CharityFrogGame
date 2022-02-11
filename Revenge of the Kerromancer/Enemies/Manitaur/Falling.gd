extends Node

onready var sm = get_parent()
onready var kino = get_parent().get_parent()

var state = null
var stateName

var previousState = null

onready var parent = get_parent()
onready var debug = get_parent().get_node("Label")
onready var sprite = parent.get_node("Graphic")

func _ready():
	pass


func startState():
	#sm.setAnimation("Falling")
	sm.midAir = true

func endState():
	kino.velocity.x = 0
	if not sm.courseCorrect:
		sm.flipSprite()
	else:
		sm.courseCorrect = false

func physics_process(_delta):
	if not kino.is_on_wall() and sm.onWall:
		sm.onWall = false
	
	if kino.is_on_floor():
		sm.changeState("Idle")
	elif kino.is_on_wall() and not sm.onWall:
		sm.courseCorrect = true
		sm.onWall = true
		sm.flipSprite()
		kino.position += Vector2(sm.dir * 5, 0)
		kino.velocity.x = 200 * sm.dir
	
	kino.velocity.y += sm.gravity * _delta
	kino.velocity = kino.move_and_slide(kino.velocity, Vector2.UP)
