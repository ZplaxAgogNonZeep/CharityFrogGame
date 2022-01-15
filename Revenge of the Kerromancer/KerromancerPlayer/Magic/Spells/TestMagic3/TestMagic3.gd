extends Node2D

var icon = preload("res://SpriteSheets/Magic/Icons/TestSpell3.png")

var itemName = "Test Magic 3"
var itemDesc = "Moves the camera or something? idk."

var cost = 1

func useMagic(kino):
	if kino.mana >= 0 and cost <= kino.mana:
		kino.mana -= cost
		kino.CutSceneMode = true
		kino.slideCamera(Vector2(100,100))
