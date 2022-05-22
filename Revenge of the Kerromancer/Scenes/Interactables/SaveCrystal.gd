extends Area2D

var dialogueName = "???"

var speech = "0|Save Crystal|Would you like to save your progress?|1"

onready var game = get_tree().root.get_node("Game")

func activate():
	game.callDialogue(self, speech)

func returnedYes(dialogueNode):
	var location = get_parent().get_parent().name + ":" + name

	game.respawnPoint = location
	game.savePlayer()
	game.saveFlags()
	
	dialogueNode.endDialogue()

func returnedNo(dialogueNode):
	dialogueNode.endDialogue()
