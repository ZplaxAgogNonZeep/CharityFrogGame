extends Node2D

onready var player = preload("res://KerromancerPlayer/Kerromancer.tscn").instance()
onready var mainMenu = preload("res://Scenes/MainMenu/MainMenu.tscn").instance()
onready var UI = get_node("CanvasLayer/UI")

func _ready():
	saveFlags()
	loadFlags()
	$LevelManager.add_child(mainMenu)
	gameVisibility(false)

func callPauseDialogue(speaker, speech):
	UI.get_node("Dialogue").startDialogue(speaker, speech)

func callDamageNumber(dam, posn):
	$DamageNumbManager.show_value(dam, false, posn)

func gameVisibility(boolean):
	UI.visible = boolean
	$DamageNumbManager.visible = boolean

func updateUI():
	UI.get_node("HUD").updateHUD(player)

func spawn():
	$LevelManager.add_child(preload("res://TestScenes/TestScene.tscn").instance())
	$LevelManager.get_child(0).get_node("PlayerManager").spawnPlayer(player)
	updateUI()

#=============================================================================================================================
# Saving Flag Data

var flags = {
	"Test1" : true,
	"Test2" : false,
	"Test3" : true
	}

func triggerFlag(flag):
	flags[flag] = true

func isFlagTriggered(flag):
	return flags[flag]

func saveFlags():
	var file = File.new()
	file.open("res://Data/flags.tres", File.WRITE)
	
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
	file.open("res://Data/flags.tres", File.READ)
	
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
# Start Menu Information
