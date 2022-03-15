extends Node2D


func spawnBullet(spawnPosition, dir, direction, side, bulletInstance, bulletMAX):
	var activeBullets = get_child_count()
	
	if activeBullets < bulletMAX:
		bulletInstance.position = spawnPosition
		bulletInstance.dir = dir
		bulletInstance.currentDirection = direction
		bulletInstance.currentSide = side
		add_child(bulletInstance)
