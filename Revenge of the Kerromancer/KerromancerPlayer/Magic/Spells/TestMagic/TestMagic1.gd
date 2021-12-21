extends Node2D

#reduces health by 2 at the cost of 1 mana

var icon = preload("res://SpriteSheets/Magic/Icons/TestSpell1.png")

var cost = 1

func useMagic(kino):
	if kino.mana >= 0 and cost <= kino.mana:
		kino.mana -= cost
		kino.takeDamage(2)


