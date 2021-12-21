extends Node2D

var Damage_Numbers = preload("res://UI/DamageNumbers/Damage_Numbers.tscn")

export var travel = Vector2(0, -80)
export var duration = .5
export var spread = PI/2

func show_value(value, crit=false):
	var fct = Damage_Numbers.instance()
	add_child(fct)
	fct.show_value(str(value), travel, duration, spread, crit)
