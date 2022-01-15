extends Node2D

var icon = preload("res://SpriteSheets/Magic/Icons/TestSpell2.png")

var itemName = "Test Magic 2"
var itemDesc = "Calls dialogue, but like don't use it. Might crash."

var cost = 1

func useMagic(kino):
	kino.game.callPauseDialogue(kino, 
	[
		"Hello There", 
		"Lets see if this dialogue works!", 
		":B:Revenge of the Kerromancer is getting closer to being released! are you excited?"
	])
