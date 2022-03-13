extends Area2D

var dialogueName = "Sign"

var posn = 0

export var dialogueText : PoolStringArray = [
	"Welcome to the testing room!",
	"If you are reading this, you are likely stuck here",
	"forever",
	"I don't really know how you got here, but you should contact @ZplaxZeep on twitter and tell him what happened",
]

var secondDialogueText = ["oh and take this"]

var lastDialogue = ["No more free handouts!"]

func activate():
	if posn == 0:
		get_tree().root.get_node("Game").callDialogue(self, dialogueText)
	elif posn == 1:
		get_tree().root.get_node("Game").callDialogue(self, secondDialogueText)
	elif posn == -1:
		get_tree().root.get_node("Game").callDialogue(self, lastDialogue)
func finishDialogue():
	if posn == 0:
		get_tree().root.get_node("Game").obtainItem("Weapon", "TestGun1")
		get_tree().root.get_node("Game").obtainItem("Magic", "BouncingBubble")
		posn += 1
	elif posn == 1:
		get_tree().root.get_node("Game").obtainItem("Magic", "TestMagic2")
		posn = -1
