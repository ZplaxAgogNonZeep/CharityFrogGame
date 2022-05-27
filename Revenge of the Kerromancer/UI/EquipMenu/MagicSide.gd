extends Control

var selectedMagic
var equipedMagic
var magicList

var section = 0
var posn = 0
var posnMem = 0

onready var emptySlot = preload("res://SpriteSheets/Magic/Icons/EmptySpell.png")
var game
var index
var equipView

func _ready():
	game = get_tree().root.get_node("Game")
	index = get_tree().root.get_node("Game").get_node("IndexSearch")
	equipView = $EquipView

func loadMagicSide(unlockedMagic, equipedMagic):
	if equipedMagic != [] and equipedMagic != null:
		selectedMagic = equipedMagic[0]
	else:
		selectedMagic = null
	self.equipedMagic = equipedMagic
	
	if unlockedMagic[0] == "":
		magicList = []

	else:
		magicList = unlockedMagic
	
	fillEquipView()
	fillSelected()
	updateEquip()
	updatePointer()


# =============================NEW===============================================

func select():
	if posn <= 9:
		
		if posn + sectionMod() >= magicList.size():
			pass
		else:
			addItemToList(selectedMagic)
		
	elif posn == 10:
		section += 1
		if section >= magicList.size() / 10:
			section = 0
	elif posn == 11:
		section -= 1
		if section <= 0:
			section = magicList.size() / 10

func remove():
	if posn <= 9:
		removeItemFromList(selectedMagic)

func goLeft():
	if posn == 0 or posn == 5:
		posnMem = posn
		posn = 11
	elif posn == 11:
		pass
	elif posn == 10:
		posn = posnMem
	else:
		posn -= 1
	if posn >= magicList.size():
		selectedMagic = "No Weapon Availible"
	else:
		selectedMagic = magicList[posn + sectionMod()]
	fillSelected()
	updatePointer()

func goRight():
	if posn == 4 or posn == 9:
		posnMem = posn
		posn = 10
	elif posn == 10:
		pass
	elif posn == 11:
		posn = posnMem
	else:
		posn += 1
	if posn >= magicList.size():
		selectedMagic = "No Weapon Availible"
	else:
		selectedMagic = magicList[posn + sectionMod()]
	fillSelected()
	updatePointer()

func goUp():
	if posn < 5:
		posn += 5
	else:
		posn -= 5
	if posn >= magicList.size():
		selectedMagic = "No Weapon Availible"
	else:
		selectedMagic = magicList[posn + sectionMod()]
	fillSelected()
	updatePointer()

func goDown():
	if posn >= 5 and posn <= 9:
		posn -= 5
	elif posn > 9:
		pass
	else:
		posn += 5
	if posn >= magicList.size():
		selectedMagic = "No Weapon Availible"
	else:
		selectedMagic = magicList[posn + sectionMod()]
	fillSelected()
	updatePointer()

func updatePointer():
	match posn:
		0:
			$EquipView/Pointer.position = Vector2(96, 0)
		1:
			$EquipView/Pointer.position = Vector2(160, 0)
		2:
			$EquipView/Pointer.position = Vector2(224, 0)
		3:
			$EquipView/Pointer.position = Vector2(288, 0)
		4:
			$EquipView/Pointer.position = Vector2(352, 0)
		5:
			$EquipView/Pointer.position = Vector2(96, 64)
		6:
			$EquipView/Pointer.position = Vector2(160, 64)
		7:
			$EquipView/Pointer.position = Vector2(224, 64)
		8:
			$EquipView/Pointer.position = Vector2(288, 64)
		9:
			$EquipView/Pointer.position = Vector2(352, 64)
		10:
			$EquipView/Pointer.position = Vector2(416, 40)
		11:
			$EquipView/Pointer.position = Vector2(32, 40)
		_:
			pass

# ================================================================================

func fillEquipView():
	var count = 0
	
	count += sectionMod()
	while count < magicList.size() and count < 10 + sectionMod() and magicList.size() != 0:
		var current = magicList[count]
		$EquipView.get_node("Slot" + str(count - sectionMod())).texture = index.searchMagicIndex(current).instance().icon
#		$EquipView.get_node("Button" + str(count - sectionMod())).disabled = false
		count += 1
	
	if magicList.size() < 10 + sectionMod():
		while count < 10 + sectionMod():
			$EquipView.get_node("Slot" + str(count - sectionMod())).texture = emptySlot
#			$EquipView.get_node("Button" + str(count - sectionMod())).disabled = true
			count += 1
	
	$EquipView.get_node("Left").disabled = true
	$EquipView.get_node("Right").disabled = true
	
	if section > 0:
		$EquipView.get_node("Left").disabled = false
	if magicList.size() > 10 + sectionMod():
		$EquipView.get_node("Right").disabled = false

func fillSelected():
	var magic = index.searchMagicIndex(selectedMagic)
	if magic != null:
		magic = index.searchMagicIndex(selectedMagic).instance()
		$Sprite.texture = magic.icon
		$MagicName.text = magic.itemName
		$MagicDesc.text = magic.itemDesc
		
		$Equip.disabled = false
		$Unequip.disabled = false
	else:
		$Sprite.texture = emptySlot
		$MagicName.text = ""
		$MagicDesc.text = ""
		
		$Equip.disabled = true
		$Unequip.disabled = true

func sectionMod():
	return 10 * section

func addItemToList(item):
	if equipedMagic == null:
		equipedMagic = []
	
	if equipedMagic.has(item):
		pass
	else:
		if equipedMagic.size() < 3:
			equipedMagic.append(item)
			updateEquip()
		else:
			equipedMagic.remove(0)
			equipedMagic.append(item)
			updateEquip()

func removeItemFromList(item):
	if equipedMagic == null:
		equipedMagic = []
	
	if equipedMagic.has(item):
		equipedMagic.remove(equipedMagic.find(item))
	
	updateEquip()

func updateEquip():
	if equipedMagic != null:
		var count = 0
		while count <= equipedMagic.size() - 1:
			get_node("Equip" + str(count)).texture = index.searchMagicIndex(equipedMagic[count]).instance().icon
			count += 1
		while count <= 2:
			get_node("Equip" + str(count)).texture = preload("res://SpriteSheets/Magic/Icons/EmptySpell.png")
			count += 1
	else:
		get_node("Equip0").texture = preload("res://SpriteSheets/Magic/Icons/EmptySpell.png")
		get_node("Equip1").texture = preload("res://SpriteSheets/Magic/Icons/EmptySpell.png")
		get_node("Equip2").texture = preload("res://SpriteSheets/Magic/Icons/EmptySpell.png")
	
	var magicInstances = []
	var count = 0
	if equipedMagic != null:
		while count < equipedMagic.size():
			magicInstances.append(index.searchMagicIndex(equipedMagic[count]).instance())
			count += 1


	get_parent().playerInstance.setMagicSlots(magicInstances)
	game.updateUI()

#func _on_Button0_pressed():
#	selectedMagic = magicList[0 - sectionMod()]
#	fillSelected()
#
#func _on_Button1_pressed():
#	selectedMagic = magicList[1 - sectionMod()]
#	fillSelected()
#
#func _on_Button2_pressed():
#	selectedMagic = magicList[2 - sectionMod()]
#	fillSelected()
#
#func _on_Button3_pressed():
#	selectedMagic = magicList[3 - sectionMod()]
#	fillSelected()
#
#func _on_Button4_pressed():
#	selectedMagic = magicList[4 - sectionMod()]
#	fillSelected()
#
#func _on_Button5_pressed():
#	selectedMagic = magicList[5 - sectionMod()]
#	fillSelected()
#
#func _on_Button6_pressed():
#	selectedMagic = magicList[6 - sectionMod()]
#	fillSelected()
#
#func _on_Button7_pressed():
#	selectedMagic = magicList[7 - sectionMod()]
#	fillSelected()
#
#func _on_Button8_pressed():
#	selectedMagic = magicList[8 - sectionMod()]
#	fillSelected()
#
#func _on_Button9_pressed():
#	selectedMagic = magicList[9 - sectionMod()]
#	fillSelected()


#func _on_Left_pressed():
#	section -= 1
#	fillEquipView()
#
#func _on_Right_pressed():
#	section += 1
#	fillEquipView()
#
#
#func _on_Equip_pressed():
#	addItemToList(selectedMagic)
#
#func _on_Unequip_pressed():
#	removeItemFromList(selectedMagic)
