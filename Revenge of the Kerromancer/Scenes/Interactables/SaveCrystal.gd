extends Area2D

var dialogueName = "???"

var speech = [":B:Would you like to save your progress?"]

onready var game = get_tree().root.get_node("Game")

func activate():
	game.callDialogue(self, speech)

func returnedYes():
	var location = get_parent().get_parent().name + ":" + name

	game.respawnPoint = location
	game.savePlayer()
	game.saveFlags()
	


func returnedNo():
	pass
