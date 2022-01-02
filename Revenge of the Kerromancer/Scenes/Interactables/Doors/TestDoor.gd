extends Area2D


func activate():
	get_tree().root.get_node("Game").spawnPlayerInLevel("TestScene", "TestSign")
