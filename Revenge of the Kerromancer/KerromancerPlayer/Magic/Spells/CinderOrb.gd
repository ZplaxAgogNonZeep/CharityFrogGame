extends Node2D


var itemName = "Cinder Orb"
var itemDesc = "Fires a ball of cinders both forward and backward"

var icon = preload("res://icon.png")
var bulletInstance = null
var cost = 0

func useMagic(kino):
	if kino.mana >= 0 and cost <= kino.mana:
		kino.mana -= cost
		
		var level = get_parent().kino.get_parent().get_parent()
		
		level.get_node("BulletManager").spawnBullet($FireSpawn.global_position, 1, "Horizontal", bulletInstance, 5)
		level.get_node("BulletManager").spawnBullet($FireSpawn.global_position, -1, "Horizontal", bulletInstance, 5)
