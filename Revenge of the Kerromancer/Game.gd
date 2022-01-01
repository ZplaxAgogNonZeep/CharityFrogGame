extends Node2D

onready var playerPath = preload("res://KerromancerPlayer/Kerromancer.tscn")
var player = null
onready var mainMenu = preload("res://Scenes/MainMenu/MainMenu.tscn").instance()
onready var UI = get_node("CanvasLayer/UI")

var flags = {
	"SaveDataExists" : false,
	}

var unlockedWeapons = []
var unlockedMagic = []

func _ready():
	gameVisibility(false)
	$LevelManager.add_child(mainMenu)

func callPauseDialogue(speaker, speech):
	UI.get_node("Dialogue").startDialogue(speaker, speech)

func callDamageNumber(dam, posn):
	$DamageNumbManager.show_value(dam, false, posn)

func gameVisibility(boolean):
	UI.visible = boolean
	$DamageNumbManager.visible = boolean

func updateUI():
	UI.get_node("HUD").updateHUD(player)

func loadLevel(levelInstance):
	$LevelManager.get_child(0).queue_free()
	
	$LevelManager.add_child(levelInstance)

#=============================================================================================================================
# Player Spawning code

func spawnPlayerInLevel(levelName, interactableName):
	print(levelName)
	loadLevel($IndexSearch.searchLevelIndex(levelName).instance())
	yield(get_tree(), "idle_frame")
	$LevelManager.get_child(0).spawnPlayer(interactableName, player)

func spawn():
	loadPlayer()
	$LevelManager.add_child(preload("res://TestScenes/TestScene.tscn").instance())
	$LevelManager.get_child(0).loadplayer()
	updateUI()

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

var existingData = false

func savePlayer():
	var file = File.new()
	file.open("res://Data/save_game.txt", file.WRITE)
	
	var fileString = ""
	fileString += str(player.health) + "/" + str(player.MAX_health) + "\n"
	fileString += str(player.mana) + "/" + str(player.MAX_mana) + "\n"
	
	fileString += player.getActiveWeapon().name + "\n"
	
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
	
	var healthList = dataList[0].split("/")
	player.health = int(healthList[0])
	player.MAX_health = int(healthList[1])
	
	var manaList = dataList[1].split("/")
	player.mana = int(manaList[0])
	player.MAX_mana = int(manaList[1])
	
	player.setActiveWeapon($IndexSearch.searchWeaponIndex(dataList[2]).instance())
	
	unlockedWeapons = dataList[3].split(",")
	
	var magicSlotStings = dataList[4].split(",")
	
	var magicSlotInstances = []
	var count = 0
	while count < magicSlotStings.size():
		magicSlotInstances.append($IndexSearch.searchMagicIndex(magicSlotStings[count]).instance())
		count += 1
	player.setMagicSlots(magicSlotInstances)
	
	unlockedMagic = dataList[5].split(",")

#=============================================================================================================================
# Start Menu Information

func startNewGame():
	gameVisibility(true)
	triggerFlag("SaveDataExists")
	player = playerPath.instance()
	# Update this to the starting area
	spawnPlayerInLevel("TestScene", "TestDoor")

