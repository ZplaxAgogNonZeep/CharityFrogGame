extends Area2D



var posn = 0

export var dialogueText : String = "0|Sign|Welcome to the testing room!>If you are reading this, you are likely stuck here>forever>I don't really know how you got here, but you should contact @ZplaxZeep on twitter and tell him what happened|0"

var secondDialogueText = "1|Sign|oh and take this|0"

var lastDialogue = "2|Sign|No more free handouts!|0"
 
func activate():
	if posn == 0:
		get_tree().root.get_node("Game").callDialogue(self, dialogueText)
	elif posn == 1:
		get_tree().root.get_node("Game").callDialogue(self, secondDialogueText)
	elif posn == -1:
		get_tree().root.get_node("Game").callDialogue(self, lastDialogue)
func setComplete(dialogueNode):
	if posn == 0:
		get_tree().root.get_node("Game").obtainItem("Weapon", "Gatling")
		get_tree().root.get_node("Game").obtainItem("Magic", "CinderOrb")
		get_tree().root.get_node("Game").obtainItem("Magic", "TailwindLunge")
		get_tree().root.get_node("Game").obtainItem("Magic", "BouncingBubble")
		get_tree().root.get_node("Game").obtainItem("Magic", "PuffofSmoke")
		posn += 1
		
	elif posn == 1:
		get_tree().root.get_node("Game").obtainItem("Magic", "TestMagic2")
		posn = -1
	
	dialogueNode.endDialogue()
