extends Node2D

# Launches the player forward while mid-air


var itemName = "Tailwind Lunge"
var itemDesc = "Use in air to lunge forward"

var icon = preload("res://SpriteSheets/Magic/Icons/TailwindLungeIcon.png")

var cost = 1

func useMagic(kino):
	var stateName = kino.get_node("StateMachine").stateName
	
	if kino.mana >= 0 and cost <= kino.mana and (stateName == "Jump" or stateName == "Falling"):
		kino.mana -= cost
		kino.Kino_updateUI()
		
		kino.get_node("StateMachine").changeState("Tailwind Lunge")
		
		
