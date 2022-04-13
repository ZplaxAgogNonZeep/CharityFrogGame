extends Node2D

#reduces health by 2 at the cost of 1 mana

var itemName = "Puff of Smoke"
var itemDesc = "When falling, jump again"

var icon = preload("res://SpriteSheets/Magic/Icons/PuffOfSmokeIcon.png")

var cost = 1

func useMagic(kino):
	if kino.mana >= 0 and cost <= kino.mana and kino.get_node("StateMachine").stateName == "Falling":
		kino.mana -= cost
		kino.Kino_updateUI()
		kino.get_node("StateMachine").changeState("Jump")
