extends Control


func loadEquipMenu(player, unlockedWeapons, activeWeapon, unlockedMagic, magicSlots):
	#TODO: FIX THIS
	get_child(0).loadMenu(player, unlockedWeapons, unlockedMagic, activeWeapon, magicSlots)
	get_child(0).visible = true
