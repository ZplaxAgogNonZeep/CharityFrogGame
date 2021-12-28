extends Node2D

# A low level gun for testing bullet behaviour

var gunName = "TestGun1"
var desc = "A very basic gun that shoots very basic bullets"

onready var bulletInstance = preload("res://KerromancerPlayer/Weapons/TestGun1/TG1Bullet.tscn")
onready var sprite = $Sprite

const MAX_BULLETS = 3


func shoot(axis):
	var dir = 1
	var posn = $RightShootPosn
	if get_parent().get_parent().sprite.flip_h:
		dir = -1
		posn = $LeftShootPosn
	
	if rotation_degrees != 0:
		posn = $RightShootPosn
	
	get_tree().root.get_node("Game").get_node("LevelManager").get_child(0).get_node("BulletManager").spawnBullet(
		get_parent().get_parent().position + getPosition(posn), 
		dir,
		axis,
		bulletInstance.instance(), 
		MAX_BULLETS
		)

func getPosition(posn):
	if rotation_degrees == -90:
		if get_parent().get_parent().sprite.flip_h:
			return position + posn.position
		else:
			return position - posn.position
		
	elif rotation_degrees == 90:
		if get_parent().get_parent().sprite.flip_h:
			return position - posn.position
		else:
			return position + posn.position
	
	return position + posn.position
