extends Node2D


func playerSpawned(player):
	get_tree().root.get_node("Game").updateUI()
	add_child(player)


