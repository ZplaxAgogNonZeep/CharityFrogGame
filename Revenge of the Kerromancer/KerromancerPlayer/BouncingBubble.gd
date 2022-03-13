extends Node2D



var itemName = "Bouncing Bubble"
var itemDesc = "Shields the player from one hit for a limited time"

var icon = preload("res://icon.png")

var cost = 0

func useMagic(kino):
	if kino.mana >= 0 and cost <= kino.mana and get_child_count() == 0:
		kino.mana -= cost
		add_child(preload("res://KerromancerPlayer/Magic/Spells/Misc/Shield.tscn").instance())
	elif kino.mana >= 0 and cost <= kino.mana:
		kino.mana -= cost
		$Shield.stock += 1
		
