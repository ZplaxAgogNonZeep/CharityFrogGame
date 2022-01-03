extends Control

const SPEED = 0.1

onready var game = get_tree().root.get_node("Game")

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

func _unhandled_input(event):
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
			$Label.percent_visible = 1
			printing = false
		elif Input.is_action_just_pressed("Interact") and !printing:
			if isYes:
				_on_Yes_pressed()
			else:
				_on_No_pressed()
	else:
		if Input.is_action_just_pressed("Interact") and printing:
			set_physics_process(false)
			$Label.percent_visible = 1
			printing = false
		elif Input.is_action_just_pressed("Interact") and !printing:
			nextPage()

func _physics_process(delta):
	printing = true
	if $Label.percent_visible < 1:
		$Label.percent_visible = lerp(0, 1, $Label.percent_visible + SPEED)
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
			print("SOMETHING IS WRONG")
			endDialogue()

func startDialogue(nSpeaker, dialogueTree):
	boolBoxMode = false
	$BoolBox.visible = false
	visible = true
	$Pointer.visible = true
	speaker = nSpeaker
	get_tree().paused = true
	dialogue = dialogueTree
	posn = 0
	
	$Name.text = nSpeaker.dialogueName + ":"
	
	
	if dialogue[posn].substr(0, 3) != ":B:":
		readPage()
	elif dialogue[posn].substr(0, 3) == ":B:":
		readBoolPage()
	else:
		print("SOMETHING IS WRONG")
		endDialogue()

func endDialogue():
	set_process_unhandled_input(false)
	set_physics_process(false)
	game.player.OutOfDialogue = true
	speaker.finishDialogue()
	speaker = null
	posn = 0
	dialogue = []
	visible = false
	$Pointer.visible = false
	get_tree().paused = false

func readPage():
	$Label.text = dialogue[posn]
	$Label.percent_visible = 0
	set_physics_process(true)
	set_process_unhandled_input(true)

func readBoolPage():
	$Label.text = dialogue[posn].substr(3)
	$Label.percent_visible = 0
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
	
	set_process_unhandled_input(false)
	set_physics_process(false)
	game.player.OutOfDialogue = true
	posn = 0
	dialogue = []
	visible = false
	get_tree().paused = false
	speaker.returnedNo()
