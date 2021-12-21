extends KinematicBody2D

var health : int = 10
var MAX_health : int = 10

var mana : int = 5
var MAX_mana : int = 5

var vulnerable = true

onready var sprite = $Graphic
onready var game = get_tree().root.get_node("Game")

var velocity = Vector2.ZERO

func _unhandled_input(_event):
	if Input.is_action_just_pressed("Shoot"):
		$WeaponManager.onShootPressed()
	if Input.is_action_just_pressed("Magic"):
		$MagicManager.onMagicPressed()
	
	if Input.is_action_just_pressed("Cycle Left"):
		$MagicManager.left()
	if Input.is_action_just_pressed("Cycle Right"):
		$MagicManager.right()

func _physics_process(_delta):
	if Input.is_action_pressed("Up"):
		$WeaponManager.changeDirection("Up")
	elif not is_on_floor() and Input.is_action_pressed("Down"):
		$WeaponManager.changeDirection("Down")
	
	if Input.is_action_just_released("Up") and not Input.is_action_pressed("Down"):
		$WeaponManager.changeDirection("Forward")
	elif Input.is_action_just_released("Down") and not Input.is_action_pressed("Up"):
		$WeaponManager.changeDirection("Forward")
	
	if Input.is_action_pressed("Down") and is_on_floor():
		$WeaponManager.changeDirection("Forward")


func flip(isLeft : bool):
	if sprite.flip_h != isLeft:
		if not is_on_floor():
			$StateMachine.momentum = 0
	
	sprite.flip_h = isLeft
	$WeaponManager.setSide(isLeft)

func takeDamage(dmg : int):
	if vulnerable:
		health -= dmg
		
		if health <= 0:
			health = 0
			die()
		
		game.updateUI()
		$DamageNumbManager.show_value(dmg, false)
		$StateMachine.changeState("Knockback")

func die():
	# TODO: Fix
	queue_free()

# ================================================================================================================
# Getters and Setters

func getMagicSlots():
	return $MagicManager.magicSlots

# ================================================================================================================
# Functions marked "Kino_" are intended for nodes that are children 
# of the Kinematic to call completely seperate parts of the game like the HUD

func Kino_updateUI():
	game.updateUI()
