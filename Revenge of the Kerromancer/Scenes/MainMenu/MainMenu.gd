extends Control

onready var menu = get_node("CanvasLayer/Menu")
onready var game = get_tree().root.get_node("Game")
onready var pointer = get_node("CanvasLayer/Menu/Pointer")

var posn = 0
var max_posn = 1

func _ready():
	game.loadFlags()
	menu.get_node("Continue").disabled = !game.isFlagTriggered("SaveDataExists")
	updatePointer()

func _unhandled_input(_event):
	if Input.is_action_just_pressed("Down"):
		if posn == max_posn:
			posn = 0
		else:
			posn += 1
		updatePointer()
		
	if Input.is_action_just_pressed("Up"):
		if posn == 0:
			posn = max_posn
		else:
			posn -= 1
		updatePointer()
	
	if Input.is_action_just_pressed("Interact"):
		selected()

func _on_New_Game_pressed():
	game.startNewGame()


func _on_Continue_pressed():
	game.continueGame()

func updatePointer():
	match posn:
		0:
			pointer.get_node("Tween").interpolate_property(pointer, "position", pointer.position, 
			Vector2(392, 304), .1, 
			pointer.get_node("Tween").TRANS_LINEAR, pointer.get_node("Tween").EASE_IN_OUT)
			pointer.get_node("Tween").start()
		1:
			pointer.get_node("Tween").interpolate_property(pointer, "position", pointer.position, 
			Vector2(392, 368), .1, 
			pointer.get_node("Tween").TRANS_LINEAR, pointer.get_node("Tween").EASE_IN_OUT)
			pointer.get_node("Tween").start()
		_:
			pass

func selected():
	match posn:
		0:
			_on_Continue_pressed()
		1:
			_on_New_Game_pressed()
		_:
			pass
