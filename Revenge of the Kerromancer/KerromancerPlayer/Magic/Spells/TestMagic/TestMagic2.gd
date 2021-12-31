extends Node2D

var icon = preload("res://SpriteSheets/Magic/Icons/TestSpell2.png")

var cost = 1

func useMagic(kino):
	kino.game.callPauseDialogue(kino, 
	[
		"Hello There", 
		"Lets see if this dialogue works!", 
		["But is it working?"]
	])
