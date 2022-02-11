extends Control


func loadEquipMenu(player, unlockedWeapons, activeWeapon, unlockedMagic, magicSlots):
	get_tree().paused = true
	var menuInstance = preload("res://UI/EquipMenu/EquipMenu.tscn").instance()
	add_child(menuInstance)
	menuInstance.loadMenu(player, unlockedWeapons, unlockedMagic, activeWeapon, magicSlots)

func unloadEquipMenu():
	get_child(0).queue_free()
	yield(get_tree(), "idle_frame")
	get_tree().paused = false
	

func loadPauseMenu():
	get_tree().paused = true
	var menuInstance = preload("res://UI/PauseMenu/PauseMenu.tscn").instance()
	add_child(menuInstance)
