extends Node2D


var itemName = "Cinder Orb"
var itemDesc = "Fires a ball of cinders both forward and backward"

var icon = preload("res://SpriteSheets/Magic/Icons/CinderOrb.png")
var bulletInstance = preload("res://KerromancerPlayer/Weapons/Fireball.tscn")
var cost = 0

enum DIRECTION {
	UP,
	DOWN,
	FORWARD
}
enum SIDE {
	LEFT,
	RIGHT
}

func useMagic(kino):
	if kino.mana >= 0 and cost <= kino.mana:
		kino.mana -= cost
		
		var level = find_parent("PlayerManager").get_parent().get_node("LevelBullets")
		
		level.spawnBullet($FireSpawn.global_position, 1,DIRECTION.FORWARD, SIDE.RIGHT, bulletInstance.instance(), 5)
		level.spawnBullet($FireSpawn.global_position, -1, DIRECTION.FORWARD, SIDE.LEFT, bulletInstance.instance(), 5)
