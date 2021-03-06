extends Node2D

onready var playerPath = preload("res://KerromancerPlayer/Kerromancer.tscn")
var player = null
onready var mainMenu = preload("res://Scenes/MainMenu/MainMenu.tscn").instance()
onready var UI = get_node("CanvasLayer/UI")

var flags = {
	"SaveDataExists" : false,
	}

var unlockedWeapons : Array = []
var unlockedMagic : Array = []

var respawnPoint 

func _ready():
	gameVisibility(false)
	$LevelManager.add_child(mainMenu)

func callDamageNumber(dam, posn):
	$DamageNumbManager.show_value(dam, false, posn)

func gameVisibility(boolean):
	UI.visible = boolean
	$DamageNumbManager.visible = boolean

func updateUI():
	UI.get_node("HUD").updateHUD(player)

func loadLevel(levelInstance):
	$LevelManager.get_child(0).queue_free()
	yield(get_tree(), "idle_frame")
	$LevelManager.add_child(levelInstance)

func callPauseMenu():
	UI.get_node("PauseManager").loadPauseMenu()

# ================================================================================================================================
# Item Managing

func openItemMenu(activeWeapon, magicSlots):
	var count = 1
	# Why are godot Arrays so fucking WEIRD
	var magicSlotsNames
	if magicSlots != []:
		magicSlotsNames = [magicSlots[0].name]
		while count < magicSlots.size():
			magicSlotsNames.append(magicSlots[count].name)
			count +=1
	var weaponName
	if activeWeapon != null:
		weaponName = activeWeapon.name
	$CanvasLayer/UI/PauseManager.loadEquipMenu(player, unlockedWeapons, weaponName, unlockedMagic, magicSlotsNames)

func obtainItem(itemType, itemName):
	var item = null
	match (itemType):
		"Weapon":
			item = $IndexSearch.searchWeaponIndex(itemName).instance()
			if unlockWeapon(item.name):
				player.weaponUnlocked(item)
		"Magic":
			item = $IndexSearch.searchMagicIndex(itemName).instance()
			if unlockMagic(item.name):
				player.magicUnlocked(item)
	updateUI()

func unlockWeapon(weaponName):
	if unlockedWeapons[0] == "":
		unlockedWeapons = [weaponName]
		return true
	else:
		if unlockedWeapons.find(weaponName) == -1:
			unlockedWeapons.append(weaponName)
			return true
		else:
			return false

func unlockMagic(magicName):
	if unlockedMagic[0] == "":
		unlockedMagic = [magicName]
		return true
	else:
		if unlockedMagic.find(magicName) == -1:
			unlockedMagic.append(magicName)
			return true
		else:
			return false


#=============================================================================================================================
# Dialogue
### Nah dude figure it out on your own
func callPauseDialogue(speaker, speech) -> void:
	UI.get_node("Dialogue").startDialogue(speaker, speech, true)

func callDialogue(speaker, speech) -> void:
	UI.get_node("Dialogue").startDialogue(speaker, speech, false)
	player.setCutSceneMode(true)

func endDialogue():
	player.setCutSceneMode(false)



#=============================================================================================================================
# Player Spawning code

func spawnPlayerInLevel(levelName, interactableName):
	UI.get_node("Transition/ColorRect").visible = true
	respawnPoint = levelName + ":" + interactableName
	
	saveTemp()
	
	yield(get_tree(),"idle_frame")
	loadLevel($IndexSearch.searchLevelIndex(levelName).instance())
	yield(get_tree(), "idle_frame")
	player = playerPath.instance()
	$LevelManager.get_child(0).spawnPlayer(interactableName, player)
	loadtemp()
	updateUI()
	
	UI.get_node("Transition/ColorRect").visible = false

func spawn():
	loadPlayer()
	$LevelManager.add_child(preload("res://TestScenes/TestScene.tscn").instance())
	$LevelManager.get_child(0).loadplayer()
	updateUI()

func respawn():
	extractRespawnPoint()
	var respawnPointList = respawnPoint.split(":")
	player.health = player.MAX_health
	yield(spawnPlayerInLevel(respawnPointList[0], respawnPointList[1]), "completed")
	loadPlayer()



#=============================================================================================================================
# Saving Flag Data

func triggerFlag(flag):
	flags[flag] = true

func isFlagTriggered(flag):
	return flags[flag]

func saveFlags():
	var file = File.new()
	file.open("res://Data/flags.txt", File.WRITE)
	
	var flagKeys = flags.keys()
	var count = 0
	var fileContent = ""
	
	while count < flagKeys.size():
		fileContent += flagKeys[count] + ":" + str(flags[flagKeys[count]]) + "\n"
		count += 1
	
	file.store_string(fileContent)
	file.close()

func loadFlags():
	flags = {}
	
	var file = File.new()
	file.open("res://Data/flags.txt", File.READ)
	
	var flagList = file.get_as_text().split("\n")
	
	var count = 0
	while count < flagList.size() - 1:
		var key_value = flagList[count].split(":")
		
		var value
		if key_value[1] == "True":
			value = true
		else:
			value = false
		
		flags[key_value[0]] = value
		count += 1
	
	file.close()

#=============================================================================================================================
# Saving player data

func savePlayer():
	var file = File.new()
	file.open("res://Data/save_game.txt", file.WRITE)
	
	var fileString = ""
	
	fileString += respawnPoint + "\n"
	
	fileString += str(player.health) + "/" + str(player.MAX_health) + "\n"
	fileString += str(player.mana) + "/" + str(player.MAX_mana) + "\n"
	
	if player.getActiveWeapon() != null:
		fileString += player.getActiveWeapon().name
	fileString += "\n"
	
	var count = 0
	while count < unlockedWeapons.size():
		fileString += unlockedWeapons[count]
		if count != unlockedWeapons.size() - 1:
			fileString += ","
		count += 1
	fileString += "\n"
	
	count = 0
	while count < player.getMagicSlots().size():
		fileString += player.getMagicSlots()[count].name
		if count != player.getMagicSlots().size() - 1:
			fileString += ","
		count += 1
	fileString += "\n"
	
	count = 0
	while count < unlockedMagic.size():
		fileString += unlockedMagic[count]
		if count != unlockedMagic.size() - 1:
			fileString += ","
		count += 1
	fileString += "\n"
	
	file.store_string(fileString)
	
	file.close()

func loadPlayer():
	
	var file = File.new()
	file.open("res://Data/save_game.txt", File.READ)
	var dataList = file.get_as_text().split("\n")
	
	respawnPoint = dataList[0]
	
	var healthList = dataList[1].split("/")
	player.health = int(healthList[0])
	player.MAX_health = int(healthList[1])
	
	var manaList = dataList[2].split("/")
	player.mana = int(manaList[0])
	player.MAX_mana = int(manaList[1])

	if $IndexSearch.searchWeaponIndex(dataList[3]) != null:
		#player.setActiveWeapon($IndexSearch.searchWeaponIndex(dataList[3]).instance())
		player.call_deferred("setActiveWeapon", $IndexSearch.searchWeaponIndex(dataList[3]).instance())
	
	unlockedWeapons = dataList[4].split(",")
	
	var magicSlotStings = dataList[5].split(",")
	
	var magicSlotInstances = []
	var count = 0
	while count < magicSlotStings.size():
		if $IndexSearch.searchMagicIndex(magicSlotStings[count]) != null:
			magicSlotInstances.append($IndexSearch.searchMagicIndex(magicSlotStings[count]).instance())
		count += 1
	player.setMagicSlots(magicSlotInstances)
	
	unlockedMagic = dataList[6].split(",")
	
	file.close()
	

func extractRespawnPoint():
	var file = File.new()
	file.open("res://Data/save_game.txt", File.READ)
	var dataList = file.get_as_text().split("\n")
	respawnPoint = dataList[0]
	file.close()

func saveTemp():
	var file = File.new()
	file.open("res://Data/temp.txt", file.WRITE)
	
	var fileString = ""
	
	fileString += respawnPoint + "\n"
	
	fileString += str(player.health) + "/" + str(player.MAX_health) + "\n"
	fileString += str(player.mana) + "/" + str(player.MAX_mana) + "\n"
	
	if player.getActiveWeapon() != null:
		fileString += player.getActiveWeapon().name
	fileString += "\n"
	
	var count = 0
	while count < unlockedWeapons.size():
		fileString += unlockedWeapons[count]
		if count != unlockedWeapons.size() - 1:
			fileString += ","
		count += 1
	fileString += "\n"
	
	count = 0
	while count < player.getMagicSlots().size():
		fileString += player.getMagicSlots()[count].name
		if count != player.getMagicSlots().size() - 1:
			fileString += ","
		count += 1
	fileString += "\n"
	
	count = 0
	while count < unlockedMagic.size():
		fileString += unlockedMagic[count]
		if count != unlockedMagic.size() - 1:
			fileString += ","
		count += 1
	fileString += "\n"
	
	file.store_string(fileString)
	
	file.close()

func loadtemp():
	var file = File.new()
	file.open("res://Data/temp.txt", File.READ)
	var dataList = file.get_as_text().split("\n")
	
	respawnPoint = dataList[0]
	
	var healthList = dataList[1].split("/")
	player.health = int(healthList[0])
	player.MAX_health = int(healthList[1])
	
	var manaList = dataList[2].split("/")
	player.mana = int(manaList[0])
	player.MAX_mana = int(manaList[1])
	
	if $IndexSearch.searchWeaponIndex(dataList[3]) != null:
		player.call_deferred("setActiveWeapon", $IndexSearch.searchWeaponIndex(dataList[3]).instance())
	
	unlockedWeapons = dataList[4].split(",")
	
	var magicSlotStings = dataList[5].split(",")
	
	var magicSlotInstances = []
	var count = 0
	while count < magicSlotStings.size():
		if $IndexSearch.searchMagicIndex(magicSlotStings[count]) != null:
			magicSlotInstances.append($IndexSearch.searchMagicIndex(magicSlotStings[count]).instance())
		count += 1
	#player.setMagicSlots(magicSlotInstances)
	player.call_deferred("setMagicSlots", magicSlotInstances)
	
	unlockedMagic = dataList[6].split(",")
	
	file.close()
	
	file.open("res://Data/temp.txt", file.WRITE)
	
	file.store_string("")
	
	file.close()

#=============================================================================================================================
# Start Menu Information

func startNewGame():
	gameVisibility(true)
	triggerFlag("SaveDataExists")
	player = playerPath.instance()
	# Update this to the starting area
	spawnPlayerInLevel("TestScene", "TestDoor")

func continueGame():
	gameVisibility(true)
	player = playerPath.instance()
	respawn()
	

func returnToMenu():
	gameVisibility(false)
	$LevelManager.get_child(0).queue_free()
	yield(get_tree(), "idle_frame")
	$LevelManager.add_child(preload("res://Scenes/MainMenu/MainMenu.tscn").instance())
