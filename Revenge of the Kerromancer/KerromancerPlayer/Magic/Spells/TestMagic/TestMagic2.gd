extends Node2D

var icon = preload("res://SpriteSheets/Magic/Icons/TestSpell2.png")

var cost = 1

func useMagic(kino):
	if kino.mana >= 0 and cost <= kino.mana:
		kino.mana -= cost
		kino.takeDamage(4)
