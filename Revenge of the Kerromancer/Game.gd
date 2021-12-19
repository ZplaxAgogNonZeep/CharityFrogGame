extends Node2D

onready var player = preload("res://KerromancerPlayer/Kerromancer.tscn").instance()

func _ready():
	$LevelManager.add_child(preload("res://TestScenes/TestScene.tscn").instance())


func updateUI():
	pass
