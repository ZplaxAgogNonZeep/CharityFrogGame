extends Control

var playerInstance = null

func loadMenu(player, unlockedWeapons, unlockedMagic, equipedWeapon, equipedMagic):
	playerInstance = player
	$WeaponSide.loadWeaponSide(unlockedWeapons, equipedWeapon)
	$MagicSide.loadMagicSide(unlockedMagic, equipedMagic)

func _unhandled_input(_event):
	if Input.is_action_just_pressed("OpenMenu"):
		get_parent().unloadEquipMenu()

