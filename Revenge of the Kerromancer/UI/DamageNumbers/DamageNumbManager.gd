extends Node2D

var Damage_Numbers = preload("res://UI/DamageNumbers/Damage_Numbers.tscn")

export var travel = Vector2(0, -20)
export var duration = .5
export var spread = PI/2

func show_value(value, crit, posn):
	var fct = Damage_Numbers.instance()
	fct.rect_position = posn
	add_child(fct)
	fct.show_value(str(value), travel, duration, spread, crit)
