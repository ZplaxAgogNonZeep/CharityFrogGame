extends Node2D

var stock := 0
export var time := 3

func _ready():
	get_parent().get_parent().kino.shielded = true
	get_parent().get_parent().kino.activeShield = self
	$Timer.start(time)

func pokeShield(dam : int):
	endShield()

func _on_Timer_timeout():
	if stock > 0:
		$Timer.start(time)
		stock -= 1
	else:
		endShield()

func endShield():
	get_parent().get_parent().kino.shielded = false
	get_parent().get_parent().kino.activeShield = null
	queue_free()
