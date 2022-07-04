extends KinematicBody2D

var health : int = 10
var MAX_health : int = 10

var mana : int = 5
var MAX_mana : int = 5

var vulnerable = true

var shielded := false
var activeShield = null

var OutOfDialogue = false
var CutSceneMode = false

onready var sprite = $Graphic
var game = null

var velocity = Vector2.ZERO

enum DIRECTION {
	UP,
	DOWN,
	FORWARD
}

var currentDirection = DIRECTION.FORWARD

enum SIDE {
	LEFT,
	RIGHT
}

var currentSide = SIDE.RIGHT

func _unhandled_input(_event):
	if Input.is_action_just_pressed("Pause"):
		game.callPauseMenu()
	
	if not CutSceneMode:
		if Input.is_action_just_pressed("OpenMenu"):
			game.openItemMenu(getActiveWeapon(), getMagicSlots())
		
		if Input.is_action_just_pressed("Interact") and !OutOfDialogue:
			$Interaction.interact()
		
		if Input.is_action_just_pressed("Shoot"):
			$WeaponManager.onShootPressed()
		
		if Input.is_action_pressed("Shoot"):
			$WeaponManager.onShootHold()
		
		if Input.is_action_just_released("Shoot"):
			$WeaponManager.onShootRelease()
		
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
			$WeaponManager.changeDirection(DIRECTION.UP)
		elif not is_on_floor() and Input.is_action_pressed("Down"):
			$WeaponManager.changeDirection(DIRECTION.DOWN)
		
		if Input.is_action_just_released("Up") and not Input.is_action_pressed("Down"):
			$WeaponManager.changeDirection(DIRECTION.FORWARD)
		elif Input.is_action_just_released("Down") and not Input.is_action_pressed("Up"):
			$WeaponManager.changeDirection(DIRECTION.FORWARD)
		
		if Input.is_action_pressed("Down") and is_on_floor():
			$WeaponManager.changeDirection(DIRECTION.FORWARD)

func flip(isLeft : bool):
	if sprite.flip_h != isLeft:
		if not is_on_floor():
			$StateMachine.momentum = 0
	
	sprite.flip_h = isLeft
	
	if isLeft:
		$WeaponManager.setSide(SIDE.LEFT)
	else:
		$WeaponManager.setSide(SIDE.RIGHT)


func takeDamage(dmg : int, instaKill=false):
	if vulnerable or instaKill:
		if shielded:
			activeShield.pokeShield(dmg)
			$StateMachine.changeState("Knockback")
		else:
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
	$Camera2D/Tween.interpolate_property(
		$Camera2D, 
		"position", 
		$Camera2D.position, 
		posn - position, 
		1, 
		Tween.EASE_IN, 
		Tween.EASE_IN_OUT)
	$Camera2D/Tween.start()
"StateMachine/Knockback"
func resetCamera():
	$Camera2D/Tween.interpolate_property(
		$Camera2D, 
		"position", 
		$Camera2D.position, 
		Vector2(0, -20), 
		1, 
		Tween.EASE_IN, 
		Tween.EASE_IN_OUT)
	$Camera2D/Tween.start()

# ================================================================================================================
# Particle Effects

func setParticles(boolean):
	$PlayerParticles.emitting = boolean

func setParticleTexture(preloadedPath):
	$PlayerParticles.texture = preloadedPath

# ================================================================================================================
# Getters and Setters

func getMagicSlots():
	return $MagicManager.get_children()

func getPrimaryPosn():
	return $MagicManager.primaryPosn

func getActiveWeapon():
	return $WeaponManager.activeWeapon

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

