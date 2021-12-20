extends Node2D

onready var player = preload("res://KerromancerPlayer/Kerromancer.tscn").instance()

onready var UI = get_node("CanvasLayer/UI")

func _ready():
	$LevelManager.add_child(preload("res://TestScenes/TestScene.tscn").instance())
	$LevelManager.get_child(0).get_node("PlayerManager").spawnPlayer(player)
	updateUI()

func updateUI():
	UI.get_node("HUD").updateHUD(player)
