extends Control

const SPEED = 0.1

onready var game = get_tree().root.get_node("Game")

onready var sprite = $SpeakBox/Sprite
onready var speak = $SpeakBox/Speak
onready var dName = $SpeakBox/Name
onready var portrait = $SpeakBox/Portrait

onready var boolSprite = $BoolBox/Sprite
onready var yn = $BoolBox/YN

var speaker = null
var dialogue = []
var posn = 0

var printing = false
var boolBoxMode = false

var isYes = true



func _ready():
	visible = false
	set_physics_process(false)
	set_process_unhandled_input(false)

func _unhandled_input(_event):
	if boolBoxMode:
		if Input.is_action_just_pressed("Up"):
			if !isYes:
				isYes = true
				updatePointer()

		if Input.is_action_just_pressed("Down"):
			if isYes:
				isYes = false
				updatePointer()

		if Input.is_action_just_pressed("Interact") and printing:
			set_physics_process(false)
			speak.percent_visible = 1
			printing = false
		elif Input.is_action_just_pressed("Interact") and !printing:
			if isYes:
				_on_Yes_pressed()
			else:
				_on_No_pressed()
	else:
		if Input.is_action_just_pressed("Interact") and printing:
			set_physics_process(false)
			speak.percent_visible = 1
			printing = false
		elif Input.is_action_just_pressed("Interact") and !printing:
			nextPage()

func _physics_process(_delta):
	printing = true
	if speak.percent_visible < 1:
		speak.percent_visible = lerp(0, 1, speak.percent_visible + SPEED)
	else:
		printing = false
		set_physics_process(false)

func updatePointer():
	if boolBoxMode:
		$Pointer.rotation_degrees = -90
		if isYes:
			$Pointer.position = Vector2(824, -56)
		else:
			$Pointer.position = Vector2(824, -8)
	else:
		$Pointer.rotation_degrees = 0
		$Pointer.position = Vector2(960, 152)


func nextPage():
	posn += 1
	
	if posn >= dialogue.size():
		endDialogue()
	else:
		if dialogue[posn].substr(0, 3) != ":B:":
			readPage()
		elif dialogue[posn].substr(0, 3) == ":B:":
			readBoolPage()
		else:
			endDialogue()

func startDialogue(nSpeaker, dialogueTree, isPause):
	
	dialogueTree.split("|")
	
#	boolBoxMode = false
#	$BoolBox.visible = false
#	visible = true
#	$Pointer.visible = true
#	speaker = nSpeaker
#
#	get_tree().paused = isPause
#
#	dialogue = dialogueTree
#	posn = 0
#
#	dName.text = nSpeaker.dialogueName + ":"
#
#
#	if dialogue[posn].substr(0, 3) != ":B:":
#		readPage()
#	elif dialogue[posn].substr(0, 3) == ":B:":
#		readBoolPage()
#	else:
#		endDialogue()

func endDialogue():
	set_process_unhandled_input(false)
	set_physics_process(false)
	game.player.OutOfDialogue = true
	game.endDialogue()
	speaker.finishDialogue()
	speaker = null
	posn = 0
	dialogue = []
	visible = false
	$Pointer.visible = false
	get_tree().paused = false

func readPage():
	speak.text = dialogue[posn]
	speak.percent_visible = 0
	set_physics_process(true)
	set_process_unhandled_input(true)

func readBoolPage():
	speak.text = dialogue[posn].substr(3)
	speak.percent_visible = 0
	set_physics_process(true)
	set_process_unhandled_input(true)
	
	displayBoolBox()

func displayBoolBox():
	$BoolBox.visible = true
	
	boolBoxMode = true
	updatePointer()
	

func _on_Yes_pressed():
	$BoolBox.visible = false
	boolBoxMode = false
	updatePointer()
	
	game.endDialogue()
	
	set_process_unhandled_input(false)
	set_physics_process(false)
	game.player.OutOfDialogue = true
	posn = 0
	dialogue = []
	visible = false
	get_tree().paused = false
	speaker.returnedYes()

func _on_No_pressed():
	$BoolBox.visible = false
	boolBoxMode = false
	updatePointer()
	
	game.endDialogue()
	
	set_process_unhandled_input(false)
	set_physics_process(false)
	game.player.OutOfDialogue = true
	posn = 0
	dialogue = []
	visible = false
	get_tree().paused = false
	speaker.returnedNo()

