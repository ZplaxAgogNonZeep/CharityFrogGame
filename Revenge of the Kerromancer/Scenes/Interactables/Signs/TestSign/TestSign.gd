extends Area2D

var dialogueName = "Sign"

var dialogueText : PoolStringArray = [
	"Welcome to the testing room!",
	"If you are reading this, you are likely stuck here",
	"forever",
	"I don't really know how you got here, but you should contact @ZplaxZeep on twitter and tell him what happened",
]

func activate():
	get_tree().root.get_node("Game").callPauseDialogue(self, dialogueText)

func finishDialogue():
	get_tree().root.get_node("Game").obtainItem("Weapon", "TestGun1")
	get_tree().root.get_node("Game").obtainItem("Magic", "TestMagic1")
