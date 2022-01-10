extends KinematicBody2D

var dialogueName = "The Kerromancer"

var health : int = 10
var MAX_health : int = 10

var mana : int = 5
var MAX_mana : int = 5

var vulnerable = true
var OutOfDialogue = false
var CutSceneMode = false

onready var sprite = $Graphic
onready var game = get_tree().root.get_node("Game")

var velocity = Vector2.ZERO

func _unhandled_input(_event):
	if Input.is_action_just_pressed("Pause"):
		pass
	
	if not CutSceneMode:
		if Input.is_action_just_pressed("OpenMenu"):
			game.openItemMenu(getActiveWeapon(), getMagicSlots())
		
		if Input.is_action_just_pressed("Interact") and !OutOfDialogue:
			$Interaction.interact()
		
		if Input.is_action_just_pressed("Shoot"):
			$WeaponManager.onShootPressed()
		if Input.is_action_just_pressed("Magic"):
			$MagicManager.onMagicPressed()
		
		if Input.is_action_just_pressed("Cycle Left"):
			$MagicManager.left()
		if Input.is_action_just_pressed("Cycle Right"):
			$MagicManager.right()
		
		if OutOfDialogue:
			OutOfDialogue = false

func _physics_process(_delta):
	if CutSceneMode:
		if $StateMachine.stateName != "Idle":
			$StateMachine.changeState("Idle")
		velocity.x = 0
		velocity.y += $StateMachine.gravity * _delta
		velocity = move_and_slide(velocity, Vector2.UP)
	else:
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
		get_tree().root.get_node("Game").callDamageNumber(dmg, position)
		$StateMachine.changeState("Knockback")

func die():
	game.respawn()
	queue_free()

func weaponUnlocked(weaponInstance):
	if $WeaponManager.get_child_count() == 0:
		$WeaponManager.setWeapon(weaponInstance)

func magicUnlocked(magicInstance):
	$MagicManager.addMagic(magicInstance)

# ================================================================================================================
# Dialogue Functions

func slideCamera(posn):
	$Camera2D/Tween.interpolate_property($Camera2D, "position", $Camera2D.position, posn - position, 1, Tween.EASE_IN, Tween.EASE_IN_OUT)
	$Camera2D/Tween.start()
"StateMachine/Knockback"
func resetCamera():
	$Camera2D/Tween.interpolate_property($Camera2D, "position", $Camera2D.position, Vector2(0, -20), 1, Tween.EASE_IN, Tween.EASE_IN_OUT)
	$Camera2D/Tween.start()

# ================================================================================================================
# Getters and Setters

func getMagicSlots():
	return $MagicManager.get_children()

func getActiveWeapon():
	return $WeaponManager.get_child(0)

func setActiveWeapon(weaponInstance):
	$WeaponManager.setWeapon(weaponInstance)

func setMagicSlots(MagicInstanceList):
	$MagicManager.setMagic(MagicInstanceList)

func setCutSceneMode(boolean):
	CutSceneMode = boolean

# ================================================================================================================
# Functions marked "Kino_" are intended for nodes that are children 
# of the Kinematic to call completely seperate parts of the game like the HUD

func Kino_updateUI():
	game.updateUI()
