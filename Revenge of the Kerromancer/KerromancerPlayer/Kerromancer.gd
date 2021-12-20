extends KinematicBody2D

var health = 10
var MAX_health = 10

var mana = 5
var MAX_mana

var activeMagic = []

onready var sprite = $Graphic
onready var game = get_tree().root.get_node("Game")

var velocity = Vector2.ZERO

func _unhandled_input(event):
	if Input.is_action_just_pressed("Shoot"):
		$WeaponManager.onShootPressed()
	if Input.is_action_just_pressed("Magic"):
		health -= 1
		game.updateUI()
	
	if Input.is_action_just_pressed("Cycle Left"):
		pass
	if Input.is_action_just_pressed("Cycle Right"):
		pass

func _physics_process(delta):
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


func flip(isLeft):
	if sprite.flip_h != isLeft:
		if not is_on_floor():
			$StateMachine.momentum = 0
	
	sprite.flip_h = isLeft
	$WeaponManager.setSide(isLeft)

func takeDamage(dmg):
	health -= dmg
	
	if health <= 0:
		health = 0
		die()
	
	game.updateUI()

func die():
	queue_free()
