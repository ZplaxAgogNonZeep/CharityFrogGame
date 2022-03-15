extends Control

var selectedMagic
var equipedMagic
var magicList

var section = 0

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
	

	
func fillEquipView():
	var count = 0
	
	count += sectionMod()
	while count < magicList.size() and count < 10 + sectionMod() and magicList.size() != 0:
		var current = magicList[count]
		$EquipView.get_node("Slot" + str(count - sectionMod())).texture = index.searchMagicIndex(current).instance().icon
		$EquipView.get_node("Button" + str(count - sectionMod())).disabled = false
		count += 1
	
	if magicList.size() < 10 + sectionMod():
		while count < 10 + sectionMod():
			$EquipView.get_node("Slot" + str(count - sectionMod())).texture = emptySlot
			$EquipView.get_node("Button" + str(count - sectionMod())).disabled = true
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
		while count < equipedMagic.size():
			get_node("Equip" + str(count)).texture = index.searchMagicIndex(equipedMagic[count]).instance().icon
			count += 1
		if count < 2:
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

func _on_Button0_pressed():
	selectedMagic = magicList[0 - sectionMod()]
	fillSelected()

func _on_Button1_pressed():
	selectedMagic = magicList[1 - sectionMod()]
	fillSelected()

func _on_Button2_pressed():
	selectedMagic = magicList[2 - sectionMod()]
	fillSelected()

func _on_Button3_pressed():
	selectedMagic = magicList[3 - sectionMod()]
	fillSelected()

func _on_Button4_pressed():
	selectedMagic = magicList[4 - sectionMod()]
	fillSelected()

func _on_Button5_pressed():
	selectedMagic = magicList[5 - sectionMod()]
	fillSelected()

func _on_Button6_pressed():
	selectedMagic = magicList[6 - sectionMod()]
	fillSelected()

func _on_Button7_pressed():
	selectedMagic = magicList[7 - sectionMod()]
	fillSelected()

func _on_Button8_pressed():
	selectedMagic = magicList[8 - sectionMod()]
	fillSelected()

func _on_Button9_pressed():
	selectedMagic = magicList[9 - sectionMod()]
	fillSelected()


func _on_Left_pressed():
	section -= 1
	fillEquipView()

func _on_Right_pressed():
	section += 1
	fillEquipView()


func _on_Equip_pressed():
	addItemToList(selectedMagic)

func _on_Unequip_pressed():
	removeItemFromList(selectedMagic)
