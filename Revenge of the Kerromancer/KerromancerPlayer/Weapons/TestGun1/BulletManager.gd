extends Node2D


func spawnBullet(spawnPosition, direction, axis, bulletInstance, bulletMAX):
	var activeBullets = get_child_count()
	
	if activeBullets < bulletMAX:
		bulletInstance.position = spawnPosition
		bulletInstance.dir = direction
		bulletInstance.axis = axis
		add_child(bulletInstance)
