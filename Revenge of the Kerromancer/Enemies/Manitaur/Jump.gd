extends Node

onready var sm = get_parent()
onready var kino = get_parent().get_parent()

var state = null
var stateName

var previousState = null

onready var parent = get_parent()
onready var debug = get_parent().get_node("Label")
onready var sprite = parent.get_node("Graphic")

var firstFrameofState

func _ready():
	pass


func startState():
	firstFrameofState = true
	sm.midAir = true
	#sm.setAnimation("Jump")
	kino.velocity.y = -625
	
	
	kino.velocity.x = 200 * sm.dir
	print("Start Jump dir: " + str(sm.dir))

func endState():
	pass

func physics_process(_delta):
	if not kino.is_on_wall() and sm.onWall:
		sm.onWall = false
	
	if kino.is_on_floor() and not firstFrameofState:
		sm.changeState("Idle")
	elif kino.is_on_wall() and not sm.onWall:
		sm.courseCorrect = true
		sm.onWall = true
		sm.flipSprite()
		kino.position += Vector2(sm.dir, 0)
		kino.velocity.x = 200 * sm.dir
		sm.changeState("Falling")
	
	firstFrameofState = false
	
	if kino.velocity.y > 0:
		sm.changeState("Falling")
		
	kino.velocity.y += sm.gravity * _delta
	kino.velocity = kino.move_and_slide(kino.velocity, Vector2.UP)
