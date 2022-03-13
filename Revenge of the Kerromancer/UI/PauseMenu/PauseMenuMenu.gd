extends Control

onready var game = get_tree().root.get_node("Game")
onready var pointer = get_node("Pointer")

var posn = 0
var max_posn = 3

func _ready():
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
	
	if Input.is_action_just_pressed("Pause"):
		get_tree().paused = false
		queue_free()

func updatePointer():
	match posn:
		0:
			pointer.get_node("Tween").interpolate_property(pointer, "position", pointer.position, 
			Vector2(392, 224), .1, 
			pointer.get_node("Tween").TRANS_LINEAR, pointer.get_node("Tween").EASE_IN_OUT)
			pointer.get_node("Tween").start()
		1:
			pointer.get_node("Tween").interpolate_property(pointer, "position", pointer.position, 
			Vector2(392, 272), .1, 
			pointer.get_node("Tween").TRANS_LINEAR, pointer.get_node("Tween").EASE_IN_OUT)
			pointer.get_node("Tween").start()
		2:
			pointer.get_node("Tween").interpolate_property(pointer, "position", pointer.position, 
			Vector2(392, 328), .1, 
			pointer.get_node("Tween").TRANS_LINEAR, pointer.get_node("Tween").EASE_IN_OUT)
			pointer.get_node("Tween").start()
		3:
			pointer.get_node("Tween").interpolate_property(pointer, "position", pointer.position, 
			Vector2(392, 384), .1, 
			pointer.get_node("Tween").TRANS_LINEAR, pointer.get_node("Tween").EASE_IN_OUT)
			pointer.get_node("Tween").start()
		_:
			pass

func selected():
	match posn:
		0:
			_on_Continue_Pressed()
		1:
			_on_MainMenu_pressed()
		2:
			_on_Options_pressed()
		3:
			_on_Quit_pressed()
		_:
			pass

func _on_Continue_Pressed():
	get_tree().paused = false
	queue_free()

func _on_MainMenu_pressed():
	game.returnToMenu()
	get_tree().paused = false
	queue_free()

func _on_Options_pressed():
	pass # Replace with function body.

func _on_Quit_pressed():
	get_tree().quit()

