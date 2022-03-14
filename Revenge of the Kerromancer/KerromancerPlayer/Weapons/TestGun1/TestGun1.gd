extends Node2D

# A low level gun for testing bullet behaviour

var itemName = "Test Gun 1"
var itemDesc = "A very basic gun that shoots very basic bullets"

var icon = preload("res://SpriteSheets/Weapons/TestGun1/TestWeaponIcon.png")

onready var bulletInstance = preload("res://KerromancerPlayer/Weapons/TestGun1/TG1Bullet.tscn")
onready var sprite = $Sprite

const MAX_BULLETS = 3


func shoot(axis):
	print(global_position)
	$Sprite.play("Fire")
	var dir = 1
	var posn = $RightShootPosn
	if get_parent().get_parent().sprite.flip_h:
		dir = -1
		posn = $LeftShootPosn
	
	if rotation_degrees != 0:
		posn = $RightShootPosn
	
	$BulletManager.spawnBullet(
		posn.position, 
		dir, 
		axis, 
		bulletInstance.instance(), 
		MAX_BULLETS)
	
#	get_tree().root.get_node("Game").get_node("LevelManager").get_child(0).get_node("BulletManager").spawnBullet(
#		get_parent().get_parent().position + getPosition(posn), 
#		dir,
#		axis,
#		bulletInstance.instance(), 
#		MAX_BULLETS)

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


func _on_Sprite_animation_finished():
	if $Sprite.animation == "Fire":
		$Sprite.play("Base")
