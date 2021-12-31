extends Node2D

onready var player = preload("res://KerromancerPlayer/Kerromancer.tscn").instance()

onready var UI = get_node("CanvasLayer/UI")

func _ready():
	pass

func callPauseDialogue(speaker, speech):
	UI.get_node("Dialogue").startDialogue(speaker, speech)

func callDamageNumber(dam, posn):
	$DamageNumbManager.show_value(dam, false, posn)

func updateUI():
	UI.get_node("HUD").updateHUD(player)

func spawn():
	$LevelManager.add_child(preload("res://TestScenes/TestScene.tscn").instance())
	$LevelManager.get_child(0).get_node("PlayerManager").spawnPlayer(player)
	updateUI()

#=============================================================================================================================
# Start Menu Information
