extends Node2D

# A low level gun for testing bullet behaviour

var gunName = "TestGun1"
var desc = "A very basic gun that shoots very basic bullets"

onready var bulletInstance = preload("res://KerromancerPlayer/Weapons/TestGun1/TG1Bullet.tscn")
onready var sprite = $Sprite

const MAX_BULLETS = 3


func shoot(axis):
	var dir = 1
	if get_parent().get_parent().sprite.flip_h:
		dir = -1
	
	get_tree().root.get_node("Game").get_node("LevelManager").get_child(0).get_node("BulletManager").spawnBullet(
		get_parent().get_parent().position + $ShootPosn.position, 
		dir,
		axis,
		bulletInstance.instance(), 
		MAX_BULLETS
		)
