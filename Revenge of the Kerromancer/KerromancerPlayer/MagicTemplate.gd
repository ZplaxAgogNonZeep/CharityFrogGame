extends Node2D

#reduces health by 2 at the cost of 1 mana


var itemName = "Null"
var itemDesc = "Nil"

var icon = preload("res://icon.png")

var cost = 0

func useMagic(kino):
	if kino.mana >= 0 and cost <= kino.mana:
		kino.mana -= cost
