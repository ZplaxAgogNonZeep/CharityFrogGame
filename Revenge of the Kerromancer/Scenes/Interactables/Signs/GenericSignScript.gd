extends Area2D

export var dialogueIndex = 0

func _ready():
	pass

func activate():
	var dialogue = getDialogue()
	

func getDialogue() -> Array:
	var file = File.new()
	file.open("res://Data/save_game.txt", File.READ)
	var dataList = file.get_as_text().split("\n")
	file.close()
	
	return dataList[dialogueIndex]
