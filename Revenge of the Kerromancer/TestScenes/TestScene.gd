extends Node2D



func _ready():
	pass

func spawnPlayer(locationName, player):
	player.position = $Interactables.get_node(locationName).position
	$PlayerManager.playerSpawned(player)
