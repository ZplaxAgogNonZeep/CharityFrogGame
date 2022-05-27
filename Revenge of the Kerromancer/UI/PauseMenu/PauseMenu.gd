extends Control

var playerInstance = null

func loadMenu(player, unlockedWeapons, unlockedMagic, equipedWeapon, equipedMagic):
	playerInstance = player
	$WeaponSide.loadWeaponSide(unlockedWeapons, equipedWeapon)
	$MagicSide.loadMagicSide(unlockedMagic, equipedMagic)

func _unhandled_input(_event):
	if Input.is_action_just_pressed("OpenMenu"):
		get_parent().unloadEquipMenu()
	
	if Input.is_action_just_pressed("Cycle Right"):
		$WeaponSide.rotateRight()
	elif Input.is_action_just_pressed("Cycle Left"):
		$WeaponSide.rotateLeft()
	
	if Input.is_action_just_pressed("Left"):
		$MagicSide.goLeft()
	elif Input.is_action_just_pressed("Right"):
		$MagicSide.goRight()
	elif Input.is_action_just_pressed("Up"):
		$MagicSide.goUp()
	elif Input.is_action_just_pressed("Down"):
		$MagicSide.goDown()
		
	if Input.is_action_just_pressed("Interact"):
		$MagicSide.select()
	elif Input.is_action_just_pressed("Jump"):
		$MagicSide.remove()
