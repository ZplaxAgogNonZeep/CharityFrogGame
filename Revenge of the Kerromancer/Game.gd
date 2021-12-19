extends Node2D


func _ready():
	add_child(preload("res://TestScenes/TestScene.tscn").instance())
