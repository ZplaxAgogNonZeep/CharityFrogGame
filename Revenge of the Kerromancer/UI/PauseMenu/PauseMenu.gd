extends Control

var playerInstance = null

func loadMenu(player, unlockedWeapons, unlockedMagic, equipedWeapon, equipedMagic):
	playerInstance = player
	$WeaponSide.loadWeaponSide(unlockedWeapons, equipedWeapon)
	#$MagicSide.loadMagicSide(unlockedMagic, equipedMagic)
