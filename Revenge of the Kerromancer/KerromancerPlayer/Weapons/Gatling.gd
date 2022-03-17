extends Node2D

# A low level gun for testing bullet behaviour

var itemName = "Null"
var itemDesc = "Nil"

var icon = preload("res://SpriteSheets/Weapons/TestGun1/TestWeaponIcon.png")

onready var bulletInstance = preload("res://KerromancerPlayer/Weapons/TestGun1/TG1Bullet.tscn")
onready var sprite = $Sprite

const MAX_BULLETS = 20

enum DIRECTION {
	UP,
	DOWN,
	FORWARD
}
enum SIDE {
	LEFT,
	RIGHT
}

var pressed = false
var coolingDown = false

var coolDown := .1

var currentDirection = DIRECTION.FORWARD
var currentSide = SIDE.RIGHT



func setSide(side):
	currentSide = side
	if side == SIDE.RIGHT:
		sprite.flip_h = false
	elif side == SIDE.LEFT:
		sprite.flip_h = true
	setDirection(currentDirection)

func setDirection(direction):
	currentDirection = direction
	match direction:
		DIRECTION.UP:
			if currentSide == SIDE.RIGHT:
				sprite.rotation_degrees = -90
			else:
				sprite.rotation_degrees = 90
		DIRECTION.DOWN:
			if currentSide == SIDE.RIGHT:
				sprite.rotation_degrees = 90
			else:
				sprite.rotation_degrees = -90
		DIRECTION.FORWARD:
			sprite.rotation_degrees = 0
		_:
			pass

func shoot():
	sprite.play("Fire")
	
	pressed = true
	_on_Timer_timeout()

func release():
	sprite.play("Idle")
	pressed = false


func _on_Sprite_animation_finished():
	if $Sprite.animation == "Fire":
		$Sprite.play("Base")


func _on_Timer_timeout():
	if pressed:
		match currentDirection:
			DIRECTION.UP:
				if currentSide == SIDE.RIGHT:
					var dir = 1
					find_parent("PlayerManager").get_parent().get_node("LevelBullets").spawnBullet(
						$UpRightPosn.global_position, 
						dir, 
						DIRECTION.UP,
						currentSide, 
						bulletInstance.instance(), 
						MAX_BULLETS)
				else:
					var dir = 1
					find_parent("PlayerManager").get_parent().get_node("LevelBullets").spawnBullet(
						$UpLeftPosn.global_position, 
						dir, 
						DIRECTION.UP,
						currentSide, 
						bulletInstance.instance(), 
						MAX_BULLETS)
			DIRECTION.DOWN:
				if currentSide == SIDE.RIGHT:
					var dir = -1
					find_parent("PlayerManager").get_parent().get_node("LevelBullets").spawnBullet(
						$DownRightPosn.global_position, 
						dir, 
						DIRECTION.DOWN,
						currentSide,
						bulletInstance.instance(), 
						MAX_BULLETS)
				else:
					var dir = -1
					find_parent("PlayerManager").get_parent().get_node("LevelBullets").spawnBullet(
						$DownLeftPosn.global_position, 
						dir, 
						DIRECTION.DOWN,
						currentSide,
						bulletInstance.instance(), 
						MAX_BULLETS)
			DIRECTION.FORWARD:
				if currentSide == SIDE.RIGHT:
					var dir = 1
					find_parent("PlayerManager").get_parent().get_node("LevelBullets").spawnBullet(
						$RightPosn.global_position, 
						dir, 
						DIRECTION.FORWARD,
						currentSide, 
						bulletInstance.instance(), 
						MAX_BULLETS)
				else:
					var dir = -1
					find_parent("PlayerManager").get_parent().get_node("LevelBullets").spawnBullet(
						$LeftPosn.global_position, 
						dir, 
						DIRECTION.FORWARD,
						currentSide, 
						bulletInstance.instance(), 
						MAX_BULLETS)
			_:
				pass
		$Timer.start(coolDown)
