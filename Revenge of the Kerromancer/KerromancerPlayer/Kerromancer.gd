extends KinematicBody2D

var health = 10
var MAX_health = 10

var mana = 5
var MAX_mana

onready var sprite = $Graphic

var velocity = Vector2.ZERO

func _unhandled_input(event):
	if Input.is_action_just_pressed("Shoot"):
		$WeaponManager.onShootPressed()

func _physics_process(delta):
	if Input.is_action_pressed("Up"):
		$WeaponManager.changeDirection("Up")
	elif not is_on_floor() and Input.is_action_just_pressed("Down"):
		$WeaponManager.changeDirection("Down")
	
	if Input.is_action_just_released("Up") and not Input.is_action_pressed("Down"):
		$WeaponManager.changeDirection("Forward")
	elif Input.is_action_just_released("Down") and not Input.is_action_pressed("Up"):
		$WeaponManager.changeDirection("Forward")
	
	if Input.is_action_pressed("Down") and is_on_floor():
		$WeaponManager.changeDirection("Forward")


func flip(isLeft):
	sprite.flip_h = isLeft
	$WeaponManager.setSide(isLeft)

func takeDamage(dmg):
	health -= dmg
	
	if health <= 0:
		health = 0
		die()

func die():
	queue_free()
