extends Control

const SPEED = 0.1

onready var game = get_tree().root.get_node("Game")

onready var sprite := $SpeakBox/Sprite
onready var speak := $SpeakBox/Speak
onready var dName := $SpeakBox/Name
onready var portrait := $SpeakBox/Portrait

onready var boolSprite := $BoolBox/Sprite
onready var yn := $BoolBox/YN

var speaker = null
var dialogue = []
var posn = 0

var printing = false

var isYes = true

var boolBoxMode = false
var isDialogueVisible = false
var isBoolBoxVisible = false

func _ready():
	set_physics_process(false)
	set_process_unhandled_input(false)

func _unhandled_input(_event):
	if isBoolBoxVisible:
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
				BoolBoxOUT()
				speaker.returnedYes(self)
			else:
				BoolBoxOUT()
				speaker.returnedNo(self)
	else:
		if Input.is_action_just_pressed("Interact") and printing:
			set_physics_process(false)
			speak.percent_visible = 1
			printing = false
		elif Input.is_action_just_pressed("Interact") and !printing:
			nextPage()

#func _physics_process(_delta):
#	printing = true
#	if speak.percent_visible < 1:
#		speak.percent_visible = lerp(0, 1, speak.percent_visible + SPEED)
#	else:
#		printing = false
#		set_physics_process(false)

func updatePointer():
	if isBoolBoxVisible:
		$Pointer.rotation_degrees = -90
		if isYes:
			$Pointer.position = Vector2(862, -40)
		else:
			$Pointer.position = Vector2(862, 16)
	else:
		$Pointer.rotation_degrees = 0
		$Pointer.position = Vector2(894, 157)


func nextPage():
	posn += 1
	
	if posn >= dialogue.size():
		getResponseFromSpeaker()
	else:
		if posn == dialogue.size() - 1 and boolBoxMode:
			readBoolPage()
		else:
			readPage()

func startDialogue(nSpeaker, set, isPause):
	
	var splitSet = set.split("|")
	# Set Notes
	# 0 = Index (Not Useful)
	# 1 = Name
	# 2 = dialogue tree (needs to be spit by >)
	# 3 = Yes/No question
	print(splitSet)
	dialogue = splitSet[2].split(">")
	speaker = nSpeaker
	dName.text = splitSet[1]
	setPortrait(dName.text)
	
	if splitSet[3] == "0":
		boolBoxMode = false
	else:
		boolBoxMode = true

	if !isDialogueVisible:
		DialogueIN()
	
	get_tree().paused = isPause
	
	posn = 0
	if posn >= dialogue.size():
		endDialogue()
	else:
		if posn == dialogue.size() - 1 and boolBoxMode:
			print(dialogue)
			readBoolPage()
		else:
			readPage()
	

func readPage():
	speak.text = dialogue[posn]
	
	$SpeakBox/Speak/Tween.interpolate_property($SpeakBox/Speak, "percent_visible", 0, 1.0, .5, Tween.TRANS_LINEAR)
	$SpeakBox/Speak/Tween.start()
#	set_physics_process(true)
	set_process_unhandled_input(true)

func readBoolPage():
	speak.text = dialogue[posn]
	$SpeakBox/Speak/Tween.interpolate_property($SpeakBox/Speak, "percent_visible", 0, 1.0, .5, Tween.TRANS_LINEAR)
	$SpeakBox/Speak/Tween.start()
#	set_physics_process(true)
	set_process_unhandled_input(true)
	
	BoolBoxIN()


func DialogueIN():
	isDialogueVisible = true
	$SpeakBox/Tween.interpolate_property($SpeakBox, "rect_position", Vector2(0, 200), Vector2(0,0), .25, Tween.TRANS_LINEAR)
	$SpeakBox/Tween.start()
	yield($SpeakBox/Tween, "tween_all_completed")
	$Pointer.visible = true
	updatePointer()

func DialogueOUT():
	if isBoolBoxVisible:
		BoolBoxOUT()
		yield($SpeakBox/Speak/Tween, "tween_all_completed")
	
	isDialogueVisible = false
	$SpeakBox/Tween.interpolate_property($SpeakBox, "rect_position", Vector2(0, 0), Vector2(0,200), .25, Tween.TRANS_LINEAR)
	$SpeakBox/Tween.start()
	$Pointer.visible = false

func BoolBoxIN():
	isBoolBoxVisible = true
	$SpeakBox/Tween.interpolate_property($SpeakBox, "rect_position", Vector2(0, 0), Vector2(-80,0), .25, Tween.TRANS_LINEAR)
	$SpeakBox/Tween.start()
	$BoolBox/Tween.interpolate_property($BoolBox, "rect_position", Vector2(1038, 157), Vector2(790, -88), .25, Tween.TRANS_LINEAR)
	$BoolBox/Tween.start()
	updatePointer()

func BoolBoxOUT():
	isBoolBoxVisible = false
	$SpeakBox/Tween.interpolate_property($SpeakBox, "rect_position", Vector2(-80, 0), Vector2(0,0), .25, Tween.TRANS_LINEAR)
	$SpeakBox/Tween.start()
	$BoolBox/Tween.interpolate_property($BoolBox, "rect_position", Vector2(790, -88), Vector2(1038, 157), .25, Tween.TRANS_LINEAR)
	$BoolBox/Tween.start()
	updatePointer()
	
	


func setPortrait(charName : String):
	# Takes the character's name and associates it with a designated portrait
	pass

func getResponseFromSpeaker():
	speaker.setComplete(self)

func endDialogue():
	set_process_unhandled_input(false)
	set_physics_process(false)
	game.player.OutOfDialogue = true
	game.endDialogue()
	
	speaker = null
	posn = 0
	dialogue = []

	DialogueOUT()
	
	$Pointer.visible = false
	get_tree().paused = false





