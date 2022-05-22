extends Area2D

export var dialogueIndex = 0

func _ready():
	pass

func activate():
	get_tree().root.get_node("Game").callDialogue(self, getDialogue())

func setComplete(dialogueNode : Control):
	dialogueNode.endDialogue()

func getDialogue() -> Array:
	var file = File.new()
	file.open("res://Data/SignData.txt", File.READ)
	var dataList = file.get_as_text().split("\n")
	file.close()
	
	return dataList[dialogueIndex]
