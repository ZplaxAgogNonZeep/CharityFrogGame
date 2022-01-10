extends Control

var selectedWeapon
var weaponList

var section = 0

onready var emptySlot = preload("res://SpriteSheets/UI/EmptySpace.png")
var game
var index
var equipView

func _ready():
	game = get_tree().root.get_node("Game")
	index = get_tree().root.get_node("Game").get_node("IndexSearch")
	equipView = $EquipView

func loadWeaponSide(unlockedWeapons, equipedWeapon):
	selectedWeapon = equipedWeapon
	weaponList = unlockedWeapons
	fillEquipView()
	fillSelected()

func fillEquipView():
	var count = 0
	
	count += sectionMod()
	while count < weaponList.size() and count < 10 + sectionMod():
		var current = weaponList[count]
		$EquipView.get_node("Slot" + str(count - sectionMod())).texture = index.searchWeaponIndex(current).instance().icon
		$EquipView.get_node("Button" + str(count - sectionMod())).disabled = false
		count += 1
	
	if weaponList.size() < 10 + sectionMod():
		while count < 10 + sectionMod():
			$EquipView.get_node("Slot" + str(count - sectionMod())).texture = emptySlot
			$EquipView.get_node("Button" + str(count - sectionMod())).disabled = true
			count += 1
	
	$EquipView.get_node("Left").disabled = true
	$EquipView.get_node("Right").disabled = true
	
	if section > 0:
		$EquipView.get_node("Left").disabled = false
	if weaponList.size() > 10 + sectionMod():
		$EquipView.get_node("Right").disabled = false

func fillSelected():
	var weapon = index.searchWeaponIndex(selectedWeapon)
	if weapon != null:
		weapon = index.searchWeaponIndex(selectedWeapon).instance()
		$Sprite.texture = weapon.icon
		$WeaponName.text = weapon.itemName
		$WeaponDesc.text = weapon.itemDesc
		
		$Equip.disabled = false
	else:
		$Sprite.texture = emptySlot
		$WeaponName.text = ""
		$WeaponDesc.text = ""

func sectionMod():
	return 10 * section

func _on_Left_pressed():
	section -= 1
	fillEquipView()

func _on_Right_pressed():
	section += 1
	fillEquipView()



func _on_Button0_pressed():
	selectedWeapon = weaponList[0 - sectionMod()]
	fillSelected()

func _on_Button1_pressed():
	selectedWeapon = weaponList[1 - sectionMod()]
	fillSelected()

func _on_Button2_pressed():
	selectedWeapon = weaponList[2 - sectionMod()]
	fillSelected()

func _on_Button3_pressed():
	selectedWeapon = weaponList[3 - sectionMod()]
	fillSelected()

func _on_Button4_pressed():
	selectedWeapon = weaponList[4 - sectionMod()]
	fillSelected()

func _on_Button5_pressed():
	selectedWeapon = weaponList[5 - sectionMod()]
	fillSelected()

func _on_Button6_pressed():
	selectedWeapon = weaponList[6 - sectionMod()]
	fillSelected()

func _on_Button7_pressed():
	selectedWeapon = weaponList[7 - sectionMod()]
	fillSelected()

func _on_Button8_pressed():
	selectedWeapon = weaponList[8 - sectionMod()]
	fillSelected()

func _on_Button9_pressed():
	selectedWeapon = weaponList[9 - sectionMod()]
	fillSelected()


func _on_Equip_pressed():
	get_parent().playerInstance.setActiveWeapon(index.searchWeaponIndex(selectedWeapon).instance())
	get_parent().unloadMenu()
